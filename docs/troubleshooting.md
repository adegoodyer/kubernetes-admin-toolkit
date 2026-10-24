# Troubleshooting Guide

Step-by-step checks for common failures. Commands marked *(workstation)* use `kubectl` from your machine; everything else runs inside the toolkit. More commands are in the [cheat sheet](commands.md).

- [A Service can't be reached](#a-service-cant-be-reached)
- [Is it a NetworkPolicy?](#is-it-a-networkpolicy)
- [DNS is slow or intermittent](#dns-is-slow-or-intermittent)
- [TLS errors](#tls-errors)
- [Can't connect to PostgreSQL or RDS](#cant-connect-to-postgresql-or-rds)
- [Seeing what a pod actually sends](#seeing-what-a-pod-actually-sends)
- [Node-level problems](#node-level-problems)

## A Service Can't Be Reached
Work up from DNS and stop at the first check that fails. That layer is where the problem is.

| #   | Check                     | Command                                                                              | If it fails, suspect                                                 |
| --- | ------------------------- | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------- |
| 1   | Name resolves             | `dig +short SVC.NS.svc.cluster.local`                                                | Typo in name or namespace, Service missing, CoreDNS down             |
| 2   | Service has endpoints     | *(workstation)* `kubectl get endpointslices -n NS -l kubernetes.io/service-name=SVC` | Selector doesn't match pod labels, pods not Ready                    |
| 3   | Pod port answers directly | `nc -zv -w 3 POD_IP PORT`                                                            | App not listening, listening on `127.0.0.1` only, wrong `targetPort` |
| 4   | Service port answers      | `nc -zv -w 3 SVC.NS.svc.cluster.local PORT`                                          | Wrong `port` in Service, NetworkPolicy, kube-proxy or CNI issue      |
| 5   | TLS handshake works       | `openssl s_client -connect SVC.NS.svc.cluster.local:443 -servername HOST </dev/null` | Wrong certificate or SNI, plain-text port, expired certificate       |
| 6   | App responds              | `curl -v https://SVC.NS.svc.cluster.local/health`                                    | Application error; check its logs                                    |

Get pod IPs and the port the app listens on:
```bash
# (workstation)
kubectl get pods -n NS -l app=APP -o wide
kubectl get svc -n NS SVC -o yaml | yq '.spec.ports'
```

If step 3 fails, attach an [ephemeral container](../README.md#ephemeral-container) to the app pod and run `ss -tlnp`. `0.0.0.0:PORT` or `*:PORT` means reachable; `127.0.0.1:PORT` means only from inside the pod.

## Is It a NetworkPolicy?
NetworkPolicies select pods by label, so the same check can pass or fail depending on which labels the toolkit pod has.
```bash
# 1. no labels: matches only default-deny or namespace-wide policies
kubectl run -it --rm toolkit -n NS --restart=Never \
  --image=adegoodyer/kubernetes-admin-toolkit:latest -- \
  nc -zv -w 3 SVC PORT

# 2. same labels as the real client
kubectl run -it --rm toolkit -n NS --restart=Never \
  --image=adegoodyer/kubernetes-admin-toolkit:latest \
  --labels=app=frontend -- \
  nc -zv -w 3 SVC PORT

# 3. from the client's own network namespace (exactly what the client sees)
kubectl debug -it CLIENT_POD -n NS \
  --image=adegoodyer/kubernetes-admin-toolkit:latest \
  --target=CLIENT_CONTAINER -- \
  nc -zv -w 3 SVC PORT
```

A connection that times out (rather than being refused) usually means traffic is being dropped by a policy. `Connection refused` means a packet arrived and nothing was listening.

To list the policies that apply *(workstation)*:
```bash
kubectl get networkpolicy -n NS
kubectl describe networkpolicy -n NS POLICY
```

## DNS Is Slow or Intermittent
```bash
# which resolver and search domains, and ndots
cat /etc/resolv.conf

# compare short name (tries each search domain) vs FQDN with trailing dot (one query)
hyperfine --warmup 3 'dig +search SVC' 'dig SVC.NS.svc.cluster.local.'

# external names with ndots:5 try up to 4 cluster suffixes first
hyperfine --warmup 3 'dig +search api.example.com' 'dig api.example.com.'

# query each CoreDNS pod directly to find a bad one
# (workstation) kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide
dig @COREDNS_POD_IP SVC.NS.svc.cluster.local

# watch lookups and look for timeouts or SERVFAIL
tcpdump -i any -nn port 53
```

Fixes to consider: use FQDNs with a trailing dot for external names, lower `ndots` in the pod's `dnsConfig`, or enable NodeLocal DNSCache.

## TLS Errors
```bash
# what certificate is presented for this name?
openssl s_client -connect HOST:443 -servername HOST </dev/null 2>/dev/null \
  | openssl x509 -noout -subject -issuer -dates -ext subjectAltName

# without -servername, many ingress controllers return a default certificate
openssl s_client -connect HOST:443 </dev/null 2>/dev/null | openssl x509 -noout -subject

# verification result at the end of the output (look for "Verify return code: 0 (ok)")
openssl s_client -connect HOST:443 -servername HOST </dev/null | tail -5
```

| Symptom                                    | Likely cause                                                           |
| ------------------------------------------ | ---------------------------------------------------------------------- |
| `certificate has expired`                  | Renewal failed; check cert-manager `Certificate` status                |
| Subject or SANs don't include the hostname | Wrong Secret on the ingress, or missing `-servername`                  |
| `unable to get local issuer certificate`   | Server isn't sending the intermediate chain, or private CA not trusted |
| `wrong version number`                     | Talking TLS to a plain-text port, or the reverse                       |

## Can't Connect to PostgreSQL or RDS
```bash
# 1. DNS and TCP
dig +short mydb.xxxx.eu-west-2.rds.amazonaws.com
nc -zv -w 3 mydb.xxxx.eu-west-2.rds.amazonaws.com 5432

# 2. server accepting connections
pg_isready -h mydb.xxxx.eu-west-2.rds.amazonaws.com -p 5432

# 3. TLS and auth, with full certificate checking
psql "host=mydb.xxxx.eu-west-2.rds.amazonaws.com port=5432 dbname=DB user=USER sslmode=verify-full sslrootcert=/eu-west-2-bundle.pem"
```

| Symptom                          | Likely cause                                                                   |
| -------------------------------- | ------------------------------------------------------------------------------ |
| `nc` times out                   | Security group or NACL doesn't allow the node or pod CIDR; wrong VPC or subnet |
| `pg_isready`: no response        | Port open but not Postgres, or instance still starting                         |
| `certificate verify failed`      | Bundle is for the wrong region; the image only has `eu-west-2`                 |
| `no pg_hba.conf entry`           | Client IP, user or database not allowed by the server's access rules |
| `password authentication failed` | Wrong credentials, or IAM auth expected                                        |

## Seeing What a Pod Actually Sends
Attach to the pod so the capture sees its traffic before any Service or NAT:
```bash
# (workstation)
kubectl debug -it POD -n NS \
  --image=adegoodyer/kubernetes-admin-toolkit:latest \
  --target=CONTAINER --profile=netadmin

# inside
tcpdump -i any -nn -w /tmp/pod.pcap
```

Copy the capture out with `kubectl cp` and the ephemeral container's name; see [Packet Capture](commands.md#packet-capture).

## Node-Level Problems
For problems that affect every pod on a node, such as routing, the CNI, kubelet or disk pressure:
```bash
# (workstation)
kubectl debug node/NODE -it \
  --image=adegoodyer/kubernetes-admin-toolkit:latest \
  --profile=sysadmin

# inside: node interfaces and routes
ip -br addr
ip route

# connections and listening ports on the node
ss -tunap

# kubelet and container runtime logs (on nodes with systemd)
chroot /host journalctl -u kubelet --since "30 min ago"
chroot /host journalctl -u containerd --since "30 min ago"

# disk usage on the node
chroot /host df -h

# all traffic for one pod, seen from the node
tcpdump -i any -nn host POD_IP
```

Delete the `node-debugger-*` pod when finished; it isn't removed automatically.

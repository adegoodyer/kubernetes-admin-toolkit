# Command Cheat Sheet

Commands to run inside the toolkit. Replace `SVC`, `NS`, `HOST` and `PORT` with your own values. In-cluster names follow `SVC.NS.svc.cluster.local`.

- [DNS](#dns)
- [Connectivity](#connectivity)
- [HTTP](#http)
- [TLS and Certificates](#tls-and-certificates)
- [Packet Capture](#packet-capture)
- [PostgreSQL](#postgresql)
- [MinIO and S3](#minio-and-s3)
- [NATS](#nats)
- [JSON and YAML](#json-and-yaml)
- [Files and Disk](#files-and-disk)
- [Benchmarking](#benchmarking)

## DNS
```bash
# which DNS server and search domains this pod uses
cat /etc/resolv.conf

# resolve a Service (dig ignores search domains unless told to)
dig +short SVC.NS.svc.cluster.local
dig +search +short SVC

# headless Service: one A record per ready pod
dig +short SVC.NS.svc.cluster.local

# SRV records for a named port
dig +short SRV _http._tcp.SVC.NS.svc.cluster.local

# reverse lookup of a pod or Service IP
dig +short -x 10.0.12.34

# ask a specific DNS server (find the cluster DNS IP with: kubectl get svc -n kube-system kube-dns)
dig @10.96.0.10 SVC.NS.svc.cluster.local

# external name, full answer with timings
dig example.com
```

With the default `ndots:5`, names with fewer than five dots are tried against every search domain first. Add a trailing dot (`example.com.`) to skip that when testing external lookups.

## Connectivity
```bash
# is a TCP port open? (-z scan only, -v verbose, -w timeout in seconds)
nc -zv -w 3 SVC.NS.svc.cluster.local 5432

# UDP port
nc -zuv -w 3 HOST 53

# several ports at once, skipping the ping check
nmap -Pn -p 80,443,5432,6379 HOST

# which hosts are up in a range
nmap -sn 10.0.12.0/24

# path and per-hop packet loss (10 probes, wide report)
mtr -rwc 10 HOST

# traceroute over TCP, which gets through firewalls that drop ICMP
traceroute -T -p 443 HOST

# interfaces, routes and listening sockets
ip -br addr
ip route
ss -tlnp

# raw TCP conversation (type a request, Ctrl+C to quit)
telnet HOST PORT
```

## HTTP
```bash
# headers only, follow redirects
curl -sIL https://HOST/

# verbose: DNS, connect, TLS handshake, request and response headers
curl -v https://HOST/path

# where the time goes
curl -sS -o /dev/null -w 'dns=%{time_namelookup}s connect=%{time_connect}s tls=%{time_appconnect}s ttfb=%{time_starttransfer}s total=%{time_total}s status=%{http_code}\n' https://HOST/

# send a request to a specific IP while keeping the hostname (tests one backend or ingress)
curl -v --resolve HOST:443:10.0.12.34 https://HOST/

# Host header against a Service or ingress controller IP
curl -v -H 'Host: app.example.com' http://10.0.12.34/

# JSON API
curl -sS http://SVC.NS.svc.cluster.local:8080/health | jq .

# POST JSON
curl -sS -X POST -H 'Content-Type: application/json' -d '{"ping":true}' http://SVC:8080/api

# download a file
wget -q https://HOST/file.tar.gz
```

## TLS and Certificates
```bash
# certificate the server presents (subject, issuer, validity dates)
openssl s_client -connect HOST:443 -servername HOST </dev/null 2>/dev/null \
  | openssl x509 -noout -subject -issuer -dates

# full chain and verification result
openssl s_client -connect HOST:443 -servername HOST -showcerts </dev/null

# check which protocol versions are accepted
openssl s_client -connect HOST:443 -tls1_2 </dev/null
openssl s_client -connect HOST:443 -tls1_3 </dev/null

# inspect a certificate file, e.g. from a mounted Secret
openssl x509 -in tls.crt -noout -text

# does a key match a certificate? (the two hashes must be equal)
openssl x509 -in tls.crt -noout -pubkey | openssl sha256
openssl pkey -in tls.key -pubout | openssl sha256
```

## Packet Capture
```bash
# DNS traffic on all interfaces (-nn: no name or port lookups)
tcpdump -i any -nn port 53

# traffic to or from one host and port
tcpdump -i any -nn host 10.0.12.34 and port 5432

# HTTP payloads as text
tcpdump -i any -nn -A 'tcp port 8080'

# write to a file for Wireshark (stop with Ctrl+C)
tcpdump -i any -nn -w /tmp/capture.pcap port 443
```

Copy a capture to your workstation:
```bash
kubectl cp NS/toolkit:/tmp/capture.pcap ./capture.pcap

# from an ephemeral container, name it with -c (see: kubectl get pod POD -o jsonpath='{.spec.ephemeralContainers[*].name}')
kubectl cp NS/POD:/tmp/capture.pcap ./capture.pcap -c debugger-abcde
```

In the [least-privilege pod](../k8s/toolkit-pod.yaml), add `-Z root` to every `tcpdump` command.

## PostgreSQL
```bash
# is the server accepting connections?
pg_isready -h HOST -p 5432

# connect
psql "host=HOST port=5432 dbname=DB user=USER"

# AWS RDS with full certificate verification (eu-west-2 bundle is in the image)
psql "host=mydb.xxxx.eu-west-2.rds.amazonaws.com port=5432 dbname=DB user=USER sslmode=verify-full sslrootcert=/eu-west-2-bundle.pem"

# one query, no prompt
PGPASSWORD=... psql -h HOST -U USER -d DB -c 'select version();'

# active connections and what they are doing
psql -h HOST -U USER -d DB -c "select pid, usename, state, wait_event, left(query, 60) from pg_stat_activity where state <> 'idle';"

# dump a database
pg_dump -h HOST -U USER -d DB -Fc -f /tmp/db.dump
```

Inside `psql`: `\l` databases, `\dt` tables, `\d TABLE` columns, `\conninfo` connection and TLS details, `\q` quit.

## MinIO and S3
```bash
# save credentials as an alias (works with MinIO and S3-compatible endpoints)
mc alias set store https://minio.example.com ACCESS_KEY SECRET_KEY

# liveness check
mc ping store --count 3

# list, copy and inspect objects
mc ls store
mc ls store/BUCKET/prefix/
mc cp ./file.txt store/BUCKET/
mc cat store/BUCKET/file.txt
mc stat store/BUCKET/file.txt

# sync a directory
mc mirror ./local-dir store/BUCKET/backup/

# server and disk status (MinIO only, needs admin credentials)
mc admin info store
```

## NATS
```bash
# save a connection and make it the default
nats context save cluster --server nats://nats.NS.svc.cluster.local:4222 --select

# can we connect, and how fast?
nats server check connection
nats rtt

# publish and subscribe (> matches everything below a subject)
nats sub 'orders.>'
nats pub orders.created '{"id":1}'

# request/reply
nats request service.ping ''

# JetStream
nats stream ls
nats stream info STREAM
nats consumer ls STREAM
nats kv ls
```

## JSON and YAML
```bash
# pretty-print and pick fields
curl -sS http://SVC:8080/status | jq '.components[] | {name, status}'

# raw values, one per line
curl -sS http://SVC:8080/items | jq -r '.[].id'

# read and edit YAML
yq '.spec.replicas' deployment.yaml
yq -i '.spec.replicas = 3' deployment.yaml

# convert between formats
yq -o json config.yaml
yq -o yaml config.json
```

## Files and Disk
```bash
# mounted volumes and free space
duf

# copy a volume's contents, preserving permissions and times
rsync -av /data/ /backup/

# SQLite database from a mounted volume
sqlite3 /data/app.db '.tables'
sqlite3 /data/app.db 'select count(*) from users;'
```

## Benchmarking
```bash
# compare response times, with warm-up runs
hyperfine --warmup 3 'curl -s -o /dev/null http://SVC.NS.svc.cluster.local/health'

# DNS lookup time: short name (search domains) vs FQDN with trailing dot
hyperfine 'dig +search SVC' 'dig SVC.NS.svc.cluster.local.'
```

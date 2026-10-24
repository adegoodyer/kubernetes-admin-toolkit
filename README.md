# kubernetes-admin-toolkit

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/adegoodyer/kubernetes-admin-toolkit) ![Docker Image Size](https://img.shields.io/docker/image-size/adegoodyer/kubernetes-admin-toolkit/latest?label=latest%20image%20size)

## Overview
- Ubuntu 24.04 container to assist in k8s testing/debugging
- `linux/amd64` and `linux/arm64`
- GMT timezone and GB locale
- AWS RDS `eu-west-2` CA bundle at `/eu-west-2-bundle.pem`
- additional tools pre-installed

```bash
curl
duf
dnsutils (dig, host, nslookup)
hyperfine
jq
mc (MinIO client - final release, upstream archived)
mtr
nats
netcat
nmap
openssl
ping
psql
rsync
sqlite3
tcpdump
telnet
traceroute
unzip
wget
yq
```

## Image Tags
| Tag                         | Meaning                                                |
| --------------------------- | ------------------------------------------------------ |
| `vX.Y.Z`                    | Released version, built from the git tag               |
| `latest`                    | Most recent release or weekly rebuild                  |
| `weekly`, `weekly-YYYYMMDD` | Weekly rebuild of master with current security patches |

## Usage

### Kubernetes
```bash
# one-off command
k run -i --tty --rm k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never -- \
curl -L --head google.co.uk

# interactive shell (removes pod after exiting shell)
k run -i --tty --rm k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never

# long-running pod (no interactive shell, need to exec in later)
k run k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never --command -- \
tail -f /dev/null

# execute subsequent commands on running pod
k exec k8s-toolkit -- ps aux

# open shell on running pod
k exec --stdin --tty k8s-toolkit -- /bin/bash

# remove pod
k delete po k8s-toolkit
```

### Docker
```bash
# run single command
d run -it --rm \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest \
curl -L --head google.co.uk

# disposable container
d run -it --rm \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container
d run -itd \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container (specify network)
d run -itd \
--network host \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container (network of another container)
# (must change CONTAINER_NAME)
d run -itd \
--network container:CONTAINER_NAME \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# connect to persistent container
d exec -it kubernetes-admin-toolkit /bin/bash

# stop and remove persistent container
# (d kill won't always remove)
d stop kubernetes-admin-toolkit && \
d rm kubernetes-admin-toolkit
```

## Security
The image is rebuilt weekly to pick up Ubuntu security patches. Vulnerability scan results are published to the repository's [Security tab](https://github.com/adegoodyer/kubernetes-admin-toolkit/security/code-scanning), and each pushed image carries an SBOM and build provenance attestation.

```bash
# view the SBOM attached to the image
docker buildx imagetools inspect adegoodyer/kubernetes-admin-toolkit:latest --format '{{ json .SBOM }}'

# scan locally
grype adegoodyer/kubernetes-admin-toolkit:latest
```

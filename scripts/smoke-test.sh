#!/bin/bash
# Checks that every tool the image promises is present and runs.
# usage: ./scripts/smoke-test.sh IMAGE [PLATFORM]
set -euo pipefail

IMAGE=${1:?usage: $0 IMAGE [PLATFORM]}
PLATFORM=${2:-}

docker run --rm ${PLATFORM:+--platform "$PLATFORM"} "$IMAGE" bash -euo pipefail -c '
  missing=0
  for cmd in curl wget jq yq dig host nslookup ping ip ss mtr nc nmap openssl psql pg_isready sqlite3 \
             rsync tcpdump telnet traceroute unzip duf hyperfine mc nats; do
    command -v "$cmd" >/dev/null || { echo "missing: $cmd"; missing=1; }
  done
  [ "$missing" -eq 0 ]

  yq --version
  nats --version
  mc --version | head -1
  psql --version
  jq --version
  curl -sS --version | head -1
  test -r /eu-west-2-bundle.pem && openssl x509 -noout -subject -in /eu-west-2-bundle.pem
  [ "$(date +%Z)" = GMT ] && locale | grep -q "LANG=en_GB.utf8"
  echo "OK: all tools present ($(uname -m))"
'

# Go tools are built in a separate stage so the Go toolchain never ships in the final image.
# The builder runs on the build machine's platform and cross-compiles for the target.
FROM --platform=$BUILDPLATFORM golang:1.27.3-bookworm@sha256:972b4110ba0f47539a975c31e52c64765e1ff19f2d74469ae4a595c6676e80a5 AS tools

ARG TARGETOS
ARG TARGETARCH

# renovate: datasource=github-releases depName=mikefarah/yq
ARG YQ_VERSION=v4.54.1
# renovate: datasource=github-releases depName=nats-io/natscli
ARG NATS_VERSION=v0.5.0
# minio/mc was archived in Nov 2025; this is its final release.
ARG MC_VERSION=RELEASE.2025-08-13T08-35-41Z

ENV CGO_ENABLED=0 GOFLAGS=-trimpath
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    export GOOS=$TARGETOS GOARCH=$TARGETARCH \
 && go install github.com/mikefarah/yq/v4@${YQ_VERSION} \
 && go install github.com/nats-io/natscli/nats@${NATS_VERSION} \
 && go install -ldflags "-X github.com/minio/mc/cmd.ReleaseTag=${MC_VERSION}" github.com/minio/mc@${MC_VERSION} \
 # cross-compiled binaries land in bin/<os>_<arch>/, native ones in bin/
 && mkdir /out && find /go/bin -type f -exec cp {} /out/ \;

# https://ubuntu.com/about/release-cycle
FROM ubuntu:26.04@sha256:c098726dd9b9733f3e885f8de0ef375206a311b0a317eadc40d347b1115fb944

ENV HOME=/
ENV TMPDIR=/tmp
ENV TZ=Etc/GMT
ENV LANG="en_GB.utf8"

# set zero interaction envar during build process only
ARG DEBIAN_FRONTEND=noninteractive

# set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# upgrade picks up security patches for packages already in the base image;
# bind9-dnsutils installs dig, nslookup and nsupdate; bind9-host installs host
# iproute2 installs ip and ss
# iputils-ping installs ping
# netcat-traditional instead of openbsd:
# https://www.geeksforgeeks.org/how-to-switch-to-netcat-traditional-in-ubuntu/
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    bind9-dnsutils \
    bind9-host \
    ca-certificates \
    curl \
    duf \
    hyperfine \
    iproute2 \
    iputils-ping \
    jq \
    locales \
    mtr-tiny \
    netcat-traditional \
    nmap \
    openssl \
    postgresql-client \
    rsync \
    sqlite3 \
    tcpdump \
    telnet \
    traceroute \
    unzip \
    wget \
 && localedef -i en_GB -c -f UTF-8 en_GB.UTF-8 \
 && rm -rf /var/lib/apt/lists/*

COPY --from=tools /out/ /usr/local/bin/

# AWS RDS regional cert bundle (eu-west-2, London) to connect to RDS Postgres over SSL/TLS
ADD --chmod=644 https://truststore.pki.rds.amazonaws.com/eu-west-2/eu-west-2-bundle.pem /eu-west-2-bundle.pem

CMD ["bash"]

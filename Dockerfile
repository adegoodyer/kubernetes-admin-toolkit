# https://ubuntu.com/about/release-cycle
FROM ubuntu:24.04

ENV HOME=/
ENV TMPDIR=/tmp
ENV TZ=Etc/GMT

# set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set locale
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8
ENV LANG="en_GB.utf8"

# set zero interaction envar during build process only
ARG DEBIAN_FRONTEND=noninteractive

# install apt packages
# dnsutils installs dig, host, nslookup and nsupdate
# iputils-ping installs ping
RUN apt-get update && apt-get install -y \
  curl \
  duf \
  dnsutils \
  host \
  iputils-ping \
  hyperfine \
  jq \
  mtr \
  # use traditional version instead of openbsd
  # https://www.geeksforgeeks.org/how-to-switch-to-netcat-traditional-in-ubuntu/
  netcat-traditional \
  nmap \
  openssl \
  postgresql \
  sqlite3 \
  rsync \
  tcpdump \
  telnet \
  traceroute \
  unzip \
  wget

# yq
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq \
  && chmod +x /usr/bin/yq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# install Go and add to root PATH
# https://go.dev/doc/devel/release
ENV GO_VERSION=1.24.0
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz \
  && tar -C /usr/local -xzf /tmp/go.tar.gz \
  && rm /tmp/go.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# install MinIO CLI via Go directly to /usr/local/bin
RUN GOBIN=/usr/local/bin go install github.com/minio/mc@latest

# install NATS CLI via Go directly to /usr/local/bin
RUN GOBIN=/usr/local/bin go install github.com/nats-io/natscli/nats@latest

# download AWS regional cert (Dublin) to connect to AWS RDS Postgres over SSL/TLS
RUN curl -o ./eu-west-2-bundle.pem https://truststore.pki.rds.amazonaws.com/eu-west-2/eu-west-2-bundle.pem

CMD ["bash"]

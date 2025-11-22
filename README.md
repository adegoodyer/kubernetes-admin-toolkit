# kubernetes-admin-toolkit

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/adegoodyer/kubernetes-admin-toolkit) ![Docker Image Size](https://img.shields.io/docker/image-size/adegoodyer/kubernetes-admin-toolkit/latest?label=latest%20image%20size)

## Overview
- Ubuntu container to assist in k8s testing/debugging
- GMT timezone and GB locale
- additional tools pre-installed

```bash
curl
duf
dnsutils
host
hyperfine
jq
mc
mtr
nats (via Go install)
netcat
nmap
openssl
psql
rsync
tcpdump
traceroute
unzip
wget
yq
```
## Usage

### Kubernetes
```bash
# start pod, execute command, exit and remove pod
k run -i --tty --rm kubernetes-admin-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never -- \
curl -L --head google.co.uk

# start pod, open shell
k run -i --tty --rm kubernetes-admin-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never

# execute command on running pod
k exec kubernetes-admin-toolkit -- ps aux

# open shell on running pod
k exec --stdin --tty kubernetes-admin-toolkit -- /bin/bash

# stop and remove pod
k delete po kubernetes-admin-toolkit

# alias (add to your .bashrc, .bash_profile, .zshrc etc)
alias kat="kubectl run -i --tty --rm ades-kubernetes-admin-toolkit --image=adegoodyer/kubernetes-admin-toolkit:latest --restart=Never"
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

## Security Scan
```bash
NAME                   INSTALLED                    FIXED-IN                       TYPE       VULNERABILITY        SEVERITY    EPSS%   RISK         
stdlib                 go1.17                       *1.20.10, 1.21.3               go-module  CVE-2023-44487       High        100.00   78.8  (kev)  
stdlib                 go1.17                       *1.21.9, 1.22.2                go-module  CVE-2023-45288       High        98.37    48.6  
stdlib                 go1.17                       1.16.9, *1.17.2                go-module  CVE-2021-38297       Critical    90.16     5.2  
login                  1:4.13+dfsg1-4ubuntu3.2                                     deb        CVE-2024-56433       Low         89.76     1.6  
passwd                 1:4.13+dfsg1-4ubuntu3.2                                     deb        CVE-2024-56433       Low         89.76     1.6  
stdlib                 go1.17                       *1.21.10, 1.22.3               go-module  CVE-2024-24787       Medium      83.64     1.2  
stdlib                 go1.22.2                     1.21.10, *1.22.3               go-module  CVE-2024-24787       Medium      83.64     1.2  
stdlib                 go1.17                       *1.21.8, 1.22.1                go-module  CVE-2024-24784       High        80.54     1.1  
stdlib                 go1.17                       *1.19.8, 1.20.3                go-module  CVE-2023-24538       Critical    69.94     0.6  
stdlib                 go1.17                       *1.21.12, 1.22.5               go-module  CVE-2024-24791       High        69.16     0.5  
stdlib                 go1.22.2                     1.21.12, *1.22.5               go-module  CVE-2024-24791       High        69.16     0.5  
stdlib                 go1.17                       1.21.0-0                       go-module  CVE-2023-24531       Critical    64.29     0.5  
stdlib                 go1.17                       *1.18.9, 1.19.4                go-module  CVE-2022-41717       Medium      69.15     0.3  
stdlib                 go1.17                       *1.19.10, 1.20.5               go-module  CVE-2023-29405       Critical    54.99     0.3  
stdlib                 go1.17                       1.16.10, *1.17.3               go-module  CVE-2021-41771       High        61.85     0.3  
stdlib                 go1.17                       *1.21.8, 1.22.1                go-module  CVE-2024-24783       Medium      62.63     0.2  
stdlib                 go1.17                       *1.19.9, 1.20.4                go-module  CVE-2023-24540       Critical    47.47     0.2  
stdlib                 go1.17                       1.16.12, *1.17.5               go-module  CVE-2021-44717       Medium      62.45     0.2  
wget                   1.21.4-1ubuntu4.1                                           deb        CVE-2024-10524       Low         71.83     0.2  
stdlib                 go1.17                       *1.21.8, 1.22.1                go-module  CVE-2023-45289       Medium      63.05     0.2  
stdlib                 go1.17                       *1.21.8, 1.22.1                go-module  CVE-2023-45290       Medium      57.64     0.2  
stdlib                 go1.17                       *1.22.7, 1.23.1                go-module  CVE-2024-34156       High        50.69     0.2  
stdlib                 go1.22.2                     *1.22.7, 1.23.1                go-module  CVE-2024-34156       High        50.69     0.2  
stdlib                 go1.17                       1.19.6                         go-module  CVE-2022-41723       High        46.36     0.2  
libcairo-gobject2      1.18.0-3build1                                              deb        CVE-2018-18064       Low         65.56     0.2  
libcairo2              1.18.0-3build1                                              deb        CVE-2018-18064       Low         65.56     0.2  
stdlib                 go1.17                       1.20.0                         go-module  CVE-2023-45287       High        40.52     0.1  
libjpeg-turbo8         2.1.5-2ubuntu2                                              deb        CVE-2018-10126       Low         63.25     0.1  
libssl3t64             3.0.13-0ubuntu3.6                                           deb        CVE-2024-41996       Low         62.70     0.1  
openssl                3.0.13-0ubuntu3.6                                           deb        CVE-2024-41996       Low         62.70     0.1  
stdlib                 go1.17                       *1.19.11, 1.20.6               go-module  CVE-2023-29406       Medium      45.75     0.1  
stdlib                 go1.17                       *1.21.8, 1.22.1                go-module  CVE-2024-24785       Medium      47.76     0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-30635       High        37.41     0.1  
stdlib                 go1.17                       *1.19.10, 1.20.5               go-module  CVE-2023-29402       Critical    32.33     0.1  
stdlib                 go1.17                       *1.22.7, 1.23.1                go-module  CVE-2024-34158       High        35.71     0.1  
stdlib                 go1.22.2                     *1.22.7, 1.23.1                go-module  CVE-2024-34158       High        35.71     0.1  
libcairo-gobject2      1.18.0-3build1                                              deb        CVE-2017-7475        Low         56.39     0.1  
libcairo2              1.18.0-3build1                                              deb        CVE-2017-7475        Low         56.39     0.1  
stdlib                 go1.17                       *1.17.9, 1.18.1                go-module  CVE-2022-24675       High        33.55   < 0.1  
stdlib                 go1.17                       *1.17.10, 1.18.2               go-module  CVE-2022-29526       Medium      39.64   < 0.1  
stdlib                 go1.17                       *1.17.9, 1.18.1                go-module  CVE-2022-28327       High        33.13   < 0.1  
libcairo-gobject2      1.18.0-3build1                                              deb        CVE-2017-9814        Low         50.54   < 0.1  
libcairo2              1.18.0-3build1                                              deb        CVE-2017-9814        Low         50.54   < 0.1  
stdlib                 go1.17                       *1.19.10, 1.20.5               go-module  CVE-2023-29404       Critical    24.75   < 0.1  
stdlib                 go1.17                       *1.21.11, 1.22.4               go-module  CVE-2024-24790       Critical    24.58   < 0.1  
stdlib                 go1.22.2                     1.21.11, *1.22.4               go-module  CVE-2024-24790       Critical    24.58   < 0.1  
stdlib                 go1.17                       *1.17.13, 1.18.5               go-module  CVE-2022-32189       High        28.34   < 0.1  
libxslt1.1             1.1.39-0exp1ubuntu0.24.04.2                                 deb        CVE-2025-7424        Medium      35.87   < 0.1  
stdlib                 go1.22.2                     1.22.3                         go-module  CVE-2024-24788       Medium      32.93   < 0.1  
stdlib                 go1.17                       1.18.6                         go-module  CVE-2022-27664       High        26.70   < 0.1  
libpython3.12-minimal  3.12.3-1ubuntu0.8                                           deb        CVE-2025-8291        Medium      34.04   < 0.1  
libpython3.12-stdlib   3.12.3-1ubuntu0.8                                           deb        CVE-2025-8291        Medium      34.04   < 0.1  
python3.12             3.12.3-1ubuntu0.8                                           deb        CVE-2025-8291        Medium      34.04   < 0.1  
python3.12-minimal     3.12.3-1ubuntu0.8                                           deb        CVE-2025-8291        Medium      34.04   < 0.1  
stdlib                 go1.17                       1.16.12, *1.17.5               go-module  CVE-2021-44716       High        27.12   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-30632       High        24.98   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-30633       High        24.98   < 0.1  
libexpat1              2.6.1-2ubuntu0.3                                            deb        CVE-2025-59375       Medium      32.52   < 0.1  
libavahi-client3       0.8-13ubuntu6                                               deb        CVE-2024-52616       Low         42.62   < 0.1  
libavahi-common-data   0.8-13ubuntu6                                               deb        CVE-2024-52616       Low         42.62   < 0.1  
libavahi-common3       0.8-13ubuntu6                                               deb        CVE-2024-52616       Low         42.62   < 0.1  
libavahi-client3       0.8-13ubuntu6                                               deb        CVE-2024-52615       Low         42.36   < 0.1  
libavahi-common-data   0.8-13ubuntu6                                               deb        CVE-2024-52615       Low         42.36   < 0.1  
libavahi-common3       0.8-13ubuntu6                                               deb        CVE-2024-52615       Low         42.36   < 0.1  
stdlib                 go1.17                       *1.19.12, 1.20.7               go-module  CVE-2023-29409       Medium      30.35   < 0.1  
libgcrypt20            1.10.3-2build1                                              deb        CVE-2024-2236        Low         41.14   < 0.1  
wget                   1.21.4-1ubuntu4.1                                           deb        CVE-2021-31879       Medium      30.65   < 0.1  
stdlib                 go1.17                       *1.19.8, 1.20.3                go-module  CVE-2023-24536       High        20.41   < 0.1  
stdlib                 go1.17                       *1.19.9, 1.20.4                go-module  CVE-2023-24539       High        20.19   < 0.1  
stdlib                 go1.17                       *1.20.8, 1.21.1                go-module  CVE-2023-39318       Medium      25.06   < 0.1  
stdlib                 go1.17                       *1.20.8, 1.21.1                go-module  CVE-2023-39319       Medium      25.06   < 0.1  
stdlib                 go1.17                       *1.20.9, 1.21.2                go-module  CVE-2023-39323       High        18.68   < 0.1  
stdlib                 go1.17                       1.16.14, *1.17.7               go-module  CVE-2022-23773       High        20.90   < 0.1  
stdlib                 go1.17                       1.16.10, *1.17.3               go-module  CVE-2021-41772       High        19.37   < 0.1  
stdlib                 go1.17                       *1.20.12, 1.21.5               go-module  CVE-2023-45285       High        17.07   < 0.1  
tar                    1.35+dfsg-3build1                                           deb        CVE-2025-45582       Medium      24.31   < 0.1  
libcairo-gobject2      1.18.0-3build1                                              deb        CVE-2019-6461        Low         33.36   < 0.1  
libcairo-gobject2      1.18.0-3build1                                              deb        CVE-2019-6462        Low         33.36   < 0.1  
libcairo2              1.18.0-3build1                                              deb        CVE-2019-6461        Low         33.36   < 0.1  
libcairo2              1.18.0-3build1                                              deb        CVE-2019-6462        Low         33.36   < 0.1  
stdlib                 go1.17                       1.19.6                         go-module  CVE-2022-41725       High        15.93   < 0.1  
curl                   8.5.0-2ubuntu10.6                                           deb        CVE-2025-0167        Low         32.56   < 0.1  
libcurl4t64            8.5.0-2ubuntu10.6                                           deb        CVE-2025-0167        Low         32.56   < 0.1  
stdlib                 go1.17                       *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45336       Medium      20.71   < 0.1  
stdlib                 go1.22.2                     *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45336       Medium      20.71   < 0.1  
stdlib                 go1.17                       *1.19.9, 1.20.4                go-module  CVE-2023-29400       High        14.70   < 0.1  
stdlib                 go1.17                       *1.22.7, 1.23.1                go-module  CVE-2024-34155       Medium      22.87   < 0.1  
stdlib                 go1.22.2                     *1.22.7, 1.23.1                go-module  CVE-2024-34155       Medium      22.87   < 0.1  
stdlib                 go1.17                       *1.19.8, 1.20.3                go-module  CVE-2023-24534       High        13.46   < 0.1  
golang.org/x/crypto    v0.42.0                      0.45.0                         go-module  GHSA-j5w8-q4qc-rx2x  Medium      19.75   < 0.1  
golang.org/x/crypto    v0.43.0                      0.45.0                         go-module  GHSA-j5w8-q4qc-rx2x  Medium      19.75   < 0.1  
libllvm17t64           1:17.0.6-9ubuntu1                                           deb        CVE-2024-7883        Low         29.71   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-32148       Medium      17.38   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-30631       High        12.10   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-1705        Medium      16.57   < 0.1  
curl                   8.5.0-2ubuntu10.6                                           deb        CVE-2025-9086        Low         27.16   < 0.1  
libcurl4t64            8.5.0-2ubuntu10.6                                           deb        CVE-2025-9086        Low         27.16   < 0.1  
gir1.2-glib-2.0        2.80.0-6ubuntu3.4                                           deb        CVE-2025-7039        Low         26.78   < 0.1  
libglib2.0-0t64        2.80.0-6ubuntu3.4                                           deb        CVE-2025-7039        Low         26.78   < 0.1  
libglib2.0-data        2.80.0-6ubuntu3.4                                           deb        CVE-2025-7039        Low         26.78   < 0.1  
stdlib                 go1.17                       1.16.8, *1.17.1                go-module  CVE-2021-39293       High        11.44   < 0.1  
libpq5                 16.10-0ubuntu0.24.04.1                                      deb        CVE-2025-12818       Medium      16.27   < 0.1  
postgresql-16          16.10-0ubuntu0.24.04.1                                      deb        CVE-2025-12818       Medium      16.27   < 0.1  
postgresql-client-16   16.10-0ubuntu0.24.04.1                                      deb        CVE-2025-12818       Medium      16.27   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-30630       High         9.16   < 0.1  
coreutils              9.4-3ubuntu6.1                                              deb        CVE-2016-2781        Low         24.86   < 0.1  
stdlib                 go1.17                       *1.20.12, 1.21.5               go-module  CVE-2023-39326       Medium      14.60   < 0.1  
stdlib                 go1.17                       *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45341       Medium      13.01   < 0.1  
stdlib                 go1.22.2                     *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45341       Medium      13.01   < 0.1  
stdlib                 go1.17                       *1.18.7, 1.19.2                go-module  CVE-2022-2880        High         8.41   < 0.1  
libssh-4               0.10.6-2ubuntu0.2                                           deb        CVE-2025-8277        Low         22.14   < 0.1  
traceroute             1:2.1.5-1                                                   deb        CVE-2023-46316       Medium      12.40   < 0.1  
curl                   8.5.0-2ubuntu10.6                                           deb        CVE-2025-10148       Low         21.51   < 0.1  
libcurl4t64            8.5.0-2ubuntu10.6                                           deb        CVE-2025-10148       Low         21.51   < 0.1  
stdlib                 go1.17                       *1.17.11, 1.18.3               go-module  CVE-2022-30629       Low         20.42   < 0.1  
stdlib                 go1.17                       1.16.14, *1.17.7               go-module  CVE-2022-23806       Critical     5.42   < 0.1  
golang.org/x/crypto    v0.42.0                      0.45.0                         go-module  GHSA-f6x5-jh6r-wrfv  Medium      11.48   < 0.1  
golang.org/x/crypto    v0.43.0                      0.45.0                         go-module  GHSA-f6x5-jh6r-wrfv  Medium      11.48   < 0.1  
libpq5                 16.10-0ubuntu0.24.04.1                                      deb        CVE-2025-12817       Medium      11.70   < 0.1  
postgresql-16          16.10-0ubuntu0.24.04.1                                      deb        CVE-2025-12817       Medium      11.70   < 0.1  
postgresql-client-16   16.10-0ubuntu0.24.04.1                                      deb        CVE-2025-12817       Medium      11.70   < 0.1  
stdlib                 go1.17                       *1.17.11, 1.18.3               go-module  CVE-2022-30580       High         6.41   < 0.1  
libxslt1.1             1.1.39-0exp1ubuntu0.24.04.2                                 deb        CVE-2025-7425        Medium      11.42   < 0.1  
rsync                  3.2.7-1ubuntu1.2                                            deb        CVE-2025-10158       Medium      11.34   < 0.1  
gir1.2-glib-2.0        2.80.0-6ubuntu3.4                                           deb        CVE-2025-3360        Low         19.53   < 0.1  
libglib2.0-0t64        2.80.0-6ubuntu3.4                                           deb        CVE-2025-3360        Low         19.53   < 0.1  
libglib2.0-data        2.80.0-6ubuntu3.4                                           deb        CVE-2025-3360        Low         19.53   < 0.1  
go                     1.24.0                       1.23.8, *1.24.2                binary     CVE-2025-22871       Critical     4.29   < 0.1  
stdlib                 go1.17                       *1.23.8, 1.24.2                go-module  CVE-2025-22871       Critical     4.29   < 0.1  
stdlib                 go1.22.2                     *1.23.8, 1.24.2                go-module  CVE-2025-22871       Critical     4.29   < 0.1  
stdlib                 go1.24.0                     1.23.8, *1.24.2                go-module  CVE-2025-22871       Critical     4.29   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-61723       High         5.46   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-61725       High         5.46   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-61723       High         5.46   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-61725       High         5.46   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-61723       High         5.46   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-61725       High         5.46   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-61723       High         5.46   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-61725       High         5.46   < 0.1  
libxslt1.1             1.1.39-0exp1ubuntu0.24.04.2                                 deb        CVE-2025-11731       Low         17.62   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-58185       Medium       7.95   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-58185       Medium       7.95   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-58185       Medium       7.95   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-58185       Medium       7.95   < 0.1  
go                     1.24.0                       1.23.12, *1.24.6               binary     CVE-2025-47907       High         4.32   < 0.1  
stdlib                 go1.17                       *1.23.12, 1.24.6               go-module  CVE-2025-47907       High         4.32   < 0.1  
stdlib                 go1.22.2                     *1.23.12, 1.24.6               go-module  CVE-2025-47907       High         4.32   < 0.1  
stdlib                 go1.24.0                     1.23.12, *1.24.6               go-module  CVE-2025-47907       High         4.32   < 0.1  
libpixman-1-0          0.42.2-1build1                                              deb        CVE-2023-37769       Medium       7.46   < 0.1  
gir1.2-glib-2.0        2.80.0-6ubuntu3.4                                           deb        CVE-2025-6052        Low         14.20   < 0.1  
libglib2.0-0t64        2.80.0-6ubuntu3.4                                           deb        CVE-2025-6052        Low         14.20   < 0.1  
libglib2.0-data        2.80.0-6ubuntu3.4                                           deb        CVE-2025-6052        Low         14.20   < 0.1  
stdlib                 go1.17                       1.16.15, *1.17.8               go-module  CVE-2022-24921       High         4.07   < 0.1  
libpam-modules         1.5.3-5ubuntu5.5                                            deb        CVE-2025-8941        Medium       6.30   < 0.1  
libpam-modules-bin     1.5.3-5ubuntu5.5                                            deb        CVE-2025-8941        Medium       6.30   < 0.1  
libpam-runtime         1.5.3-5ubuntu5.5                                            deb        CVE-2025-8941        Medium       6.30   < 0.1  
libpam0g               1.5.3-5ubuntu5.5                                            deb        CVE-2025-8941        Medium       6.30   < 0.1  
stdlib                 go1.17                       1.16.14, *1.17.7               go-module  CVE-2022-23772       High         3.25   < 0.1  
stdlib                 go1.17                       *1.19.7, 1.20.2                go-module  CVE-2023-24532       Medium       5.25   < 0.1  
stdlib                 go1.17                       *1.18.7, 1.19.2                go-module  CVE-2022-41715       High         2.92   < 0.1  
stdlib                 go1.17                       1.19.6                         go-module  CVE-2022-41724       High         2.61   < 0.1  
stdlib                 go1.17                       *1.18.7, 1.19.2                go-module  CVE-2022-2879        High         2.55   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-58186       Medium       5.16   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-61724       Medium       5.16   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-58186       Medium       5.16   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-61724       Medium       5.16   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-58186       Medium       5.16   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-61724       Medium       5.16   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-58186       Medium       5.16   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-61724       Medium       5.16   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-47912       Medium       5.05   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-47912       Medium       5.05   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-47912       Medium       5.05   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-47912       Medium       5.05   < 0.1  
go                     1.24.0                       1.23.12, *1.24.6               binary     CVE-2025-47906       Medium       3.94   < 0.1  
stdlib                 go1.17                       *1.23.12, 1.24.6               go-module  CVE-2025-47906       Medium       3.94   < 0.1  
stdlib                 go1.22.2                     *1.23.12, 1.24.6               go-module  CVE-2025-47906       Medium       3.94   < 0.1  
stdlib                 go1.24.0                     1.23.12, *1.24.6               go-module  CVE-2025-47906       Medium       3.94   < 0.1  
go                     1.24.0                       1.24.4                         binary     CVE-2025-22874       High         1.98   < 0.1  
stdlib                 go1.24.0                     1.24.4                         go-module  CVE-2025-22874       High         1.98   < 0.1  
x11-common             1:7.7+23ubuntu3                                             deb        CVE-2023-5574        Low          9.52   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-28131       High         1.53   < 0.1  
go                     1.24.0                       *1.24.9, 1.25.3                binary     CVE-2025-58187       High         1.47   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-58188       High         1.47   < 0.1  
stdlib                 go1.17                       *1.24.9, 1.25.3                go-module  CVE-2025-58187       High         1.47   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-58188       High         1.47   < 0.1  
stdlib                 go1.22.2                     *1.24.9, 1.25.3                go-module  CVE-2025-58187       High         1.47   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-58188       High         1.47   < 0.1  
stdlib                 go1.24.0                     *1.24.9, 1.25.3                go-module  CVE-2025-58187       High         1.47   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-58188       High         1.47   < 0.1  
stdlib                 go1.17                       *1.19.8, 1.20.3                go-module  CVE-2023-24537       High         1.46   < 0.1  
libssl3t64             3.0.13-0ubuntu3.6                                           deb        CVE-2025-27587       Low          8.76   < 0.1  
openssl                3.0.13-0ubuntu3.6                                           deb        CVE-2025-27587       Low          8.76   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-58189       Medium       3.29   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-58189       Medium       3.29   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-58189       Medium       3.29   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-58189       Medium       3.29   < 0.1  
libpython3.12-minimal  3.12.3-1ubuntu0.8                                           deb        CVE-2025-6075        Medium       3.10   < 0.1  
libpython3.12-stdlib   3.12.3-1ubuntu0.8                                           deb        CVE-2025-6075        Medium       3.10   < 0.1  
python3.12             3.12.3-1ubuntu0.8                                           deb        CVE-2025-6075        Medium       3.10   < 0.1  
python3.12-minimal     3.12.3-1ubuntu0.8                                           deb        CVE-2025-6075        Medium       3.10   < 0.1  
libicu74               74.2-1ubuntu3.1                                             deb        CVE-2025-5222        Low          6.72   < 0.1  
stdlib                 go1.17                       *1.22.12, 1.23.6, 1.24.0-rc.3  go-module  CVE-2025-22866       Medium       2.98   < 0.1  
stdlib                 go1.22.2                     *1.22.12, 1.23.6, 1.24.0-rc.3  go-module  CVE-2025-22866       Medium       2.98   < 0.1  
libxslt1.1             1.1.39-0exp1ubuntu0.24.04.2                                 deb        CVE-2025-10911       Medium       1.80   < 0.1  
mtr                    0.95-1.1ubuntu0.1                                           deb        CVE-2025-49809       Low          5.00   < 0.1  
stdlib                 go1.17                       *1.19.10, 1.20.5               go-module  CVE-2023-29403       High         0.68   < 0.1  
go                     1.24.0                       1.23.10, *1.24.4               binary     CVE-2025-4673        Medium       1.04   < 0.1  
stdlib                 go1.17                       *1.23.10, 1.24.4               go-module  CVE-2025-4673        Medium       1.04   < 0.1  
stdlib                 go1.22.2                     *1.23.10, 1.24.4               go-module  CVE-2025-4673        Medium       1.04   < 0.1  
stdlib                 go1.24.0                     1.23.10, *1.24.4               go-module  CVE-2025-4673        Medium       1.04   < 0.1  
libcairo-gobject2      1.18.0-3build1                                              deb        CVE-2025-50422       Low          3.86   < 0.1  
libcairo2              1.18.0-3build1                                              deb        CVE-2025-50422       Low          3.86   < 0.1  
go                     1.24.0                       1.23.11, *1.24.5               binary     CVE-2025-4674        High         0.39   < 0.1  
stdlib                 go1.17                       *1.23.11, 1.24.5               go-module  CVE-2025-4674        High         0.39   < 0.1  
stdlib                 go1.22.2                     *1.23.11, 1.24.5               go-module  CVE-2025-4674        High         0.39   < 0.1  
stdlib                 go1.24.0                     1.23.11, *1.24.5               go-module  CVE-2025-4674        High         0.39   < 0.1  
go                     1.24.0                       *1.24.8, 1.25.2                binary     CVE-2025-58183       Medium       1.44   < 0.1  
stdlib                 go1.17                       *1.24.8, 1.25.2                go-module  CVE-2025-58183       Medium       1.44   < 0.1  
stdlib                 go1.22.2                     *1.24.8, 1.25.2                go-module  CVE-2025-58183       Medium       1.44   < 0.1  
stdlib                 go1.24.0                     *1.24.8, 1.25.2                go-module  CVE-2025-58183       Medium       1.44   < 0.1  
coreutils              9.4-3ubuntu6.1                                              deb        CVE-2025-5278        Low          2.84   < 0.1  
gpgv                   2.4.4-2ubuntu17.3                                           deb        CVE-2022-3219        Low          1.43   < 0.1  
libncurses6            6.4+20240113-1ubuntu2                                       deb        CVE-2025-6141        Low          1.16   < 0.1  
libncursesw6           6.4+20240113-1ubuntu2                                       deb        CVE-2025-6141        Low          1.16   < 0.1  
libtinfo6              6.4+20240113-1ubuntu2                                       deb        CVE-2025-6141        Low          1.16   < 0.1  
ncurses-base           6.4+20240113-1ubuntu2                                       deb        CVE-2025-6141        Low          1.16   < 0.1  
ncurses-bin            6.4+20240113-1ubuntu2                                       deb        CVE-2025-6141        Low          1.16   < 0.1  
stdlib                 go1.17                       *1.21.11, 1.22.4               go-module  CVE-2024-24789       Medium       0.29   < 0.1  
stdlib                 go1.22.2                     1.21.11, *1.22.4               go-module  CVE-2024-24789       Medium       0.29   < 0.1  
stdlib                 go1.17                       *1.17.12, 1.18.4               go-module  CVE-2022-1962        Medium       0.19   < 0.1  
libxml2                2.9.14+dfsg-1.3ubuntu3.6                                    deb        CVE-2025-8732        Low          0.55   < 0.1  
jq                     1.7.1-3ubuntu0.24.04.1                                      deb        CVE-2025-9403        Negligible   8.23   < 0.1  
libjq1                 1.7.1-3ubuntu0.24.04.1                                      deb        CVE-2025-9403        Negligible   8.23   < 0.1  
libgnutls30t64         3.8.3-1.1ubuntu3.4                                          deb        CVE-2025-9820        Medium        N/A     N/A  
libxml2                2.9.14+dfsg-1.3ubuntu3.6                                    deb        CVE-2025-12863       Medium        N/A     N/A
```

## SBOM
```bash
NAME                                              VERSION                                  TYPE                        
@prometheus-io/app                                0.300.1                                  npm                          
@prometheus-io/codemirror-promql                  0.303.0                                  npm                          
@prometheus-io/lezer-promql                       0.303.0                                  npm                          
@prometheus-io/mantine-ui                         0.303.0                                  npm                          
adduser                                           3.137ubuntu1                             deb                          
adwaita-icon-theme                                46.0-1                                   deb                          
aead.dev/minisign                                 v0.3.0                                   go-module                    
apt                                               2.8.3                                    deb                          
at-spi2-common                                    2.52.0-1build1                           deb                          
at-spi2-core                                      2.52.0-1build1                           deb                          
base-files                                        13ubuntu10.3                             deb                          
base-passwd                                       3.6.3build1                              deb                          
bash                                              5.2.21-2ubuntu4                          deb                          
bind9-dnsutils                                    1:9.18.39-0ubuntu0.24.04.2               deb                          
bind9-host                                        1:9.18.39-0ubuntu0.24.04.2               deb                          
bind9-libs                                        1:9.18.39-0ubuntu0.24.04.2               deb                          
bsdutils                                          1:2.39.3-9ubuntu6.3                      deb                          
ca-certificates                                   20240203                                 deb                          
cmd/addr2line                                     UNKNOWN                                  go-module                    
cmd/asm                                           UNKNOWN                                  go-module                    
cmd/buildid                                       UNKNOWN                                  go-module                    
cmd/cgo                                           UNKNOWN                                  go-module                    
cmd/compile                                       UNKNOWN                                  go-module                    
cmd/covdata                                       UNKNOWN                                  go-module                    
cmd/cover                                         UNKNOWN                                  go-module                    
cmd/doc                                           UNKNOWN                                  go-module                    
cmd/fix                                           UNKNOWN                                  go-module                    
cmd/go                                            UNKNOWN                                  go-module                    
cmd/gofmt                                         UNKNOWN                                  go-module                    
cmd/link                                          UNKNOWN                                  go-module                    
cmd/nm                                            UNKNOWN                                  go-module                    
cmd/objdump                                       UNKNOWN                                  go-module                    
cmd/pack                                          UNKNOWN                                  go-module                    
cmd/pprof                                         UNKNOWN                                  go-module                    
cmd/preprofile                                    UNKNOWN                                  go-module                    
cmd/test2json                                     UNKNOWN                                  go-module                    
cmd/trace                                         UNKNOWN                                  go-module                    
cmd/vet                                           UNKNOWN                                  go-module                    
coreutils                                         9.4-3ubuntu6.1                           deb                          
curl                                              8.5.0-2ubuntu10.6                        deb                          
dario.cat/mergo                                   v1.0.2                                   go-module                    
dash                                              0.5.12-6ubuntu5                          deb                          
dbus                                              1.14.10-4ubuntu4.1                       deb                          
dbus-bin                                          1.14.10-4ubuntu4.1                       deb                          
dbus-daemon                                       1.14.10-4ubuntu4.1                       deb                          
dbus-python                                       1.3.2                                    python                       
dbus-session-bus-common                           1.14.10-4ubuntu4.1                       deb                          
dbus-system-bus-common                            1.14.10-4ubuntu4.1                       deb                          
dbus-user-session                                 1.14.10-4ubuntu4.1                       deb                          
dconf-gsettings-backend                           0.40.0-4ubuntu0.1                        deb                          
dconf-service                                     0.40.0-4ubuntu0.1                        deb                          
debconf                                           1.5.86ubuntu1                            deb                          
debianutils                                       5.17build1                               deb                          
diffutils                                         1:3.10-1build1                           deb                          
dmsetup                                           2:1.02.185-3ubuntu3.2                    deb                          
dnsutils                                          1:9.18.39-0ubuntu0.24.04.2               deb                          
dpkg                                              1.22.6ubuntu6.5                          deb                          
duf                                               0.8.1-1ubuntu0.24.04.3                   deb                          
e2fsprogs                                         1.47.0-2.4~exp1ubuntu4.1                 deb                          
ev-signed-file                                    UNKNOWN                                  binary     (+1 duplicate)    
example.com/go117                                 UNKNOWN                                  go-module                    
findutils                                         4.9.0-5build1                            deb                          
fontconfig                                        2.15.0-1.1ubuntu2                        deb                          
fontconfig-config                                 2.15.0-1.1ubuntu2                        deb                          
fonts-dejavu-core                                 2.37-8                                   deb                          
fonts-dejavu-mono                                 2.37-8                                   deb                          
gcc-14-base                                       14.2.0-4ubuntu2~24.04                    deb                          
gir1.2-girepository-2.0                           1.80.1-1                                 deb                          
gir1.2-glib-2.0                                   2.80.0-6ubuntu3.4                        deb                          
github.com/AlecAivazis/survey/v2                  v2.3.7                                   go-module                    
github.com/HdrHistogram/hdrhistogram-go           v1.1.2                                   go-module                    
github.com/Masterminds/goutils                    v1.1.1                                   go-module                    
github.com/Masterminds/semver/v3                  v3.4.0                                   go-module                    
github.com/VividCortex/ewma                       v1.2.0                                   go-module                    
github.com/a8m/envsubst                           v1.4.3                                   go-module                    
github.com/acarl005/stripansi                     v0.0.0-20180116102854-5a71ef0e047d       go-module                    
github.com/alecthomas/participle/v2               v2.1.4                                   go-module                    
github.com/antithesishq/antithesis-sdk-go         v0.5.0                                   go-module                    
github.com/aymanbagabas/go-osc52/v2               v2.0.1                                   go-module                    
github.com/beorn7/perks                           v1.0.1                                   go-module  (+1 duplicate)    
github.com/cespare/xxhash/v2                      v2.3.0                                   go-module  (+1 duplicate)    
github.com/charmbracelet/bubbles                  v0.20.0                                  go-module                    
github.com/charmbracelet/bubbletea                v1.3.4                                   go-module                    
github.com/charmbracelet/colorprofile             v0.2.3-0.20250311203215-f60798e515dc     go-module                    
github.com/charmbracelet/lipgloss                 v1.1.0                                   go-module                    
github.com/charmbracelet/x/ansi                   v0.8.0                                   go-module                    
github.com/charmbracelet/x/cellbuf                v0.0.13-0.20250311204145-2c3ea96c31dd    go-module                    
github.com/charmbracelet/x/term                   v0.2.1                                   go-module                    
github.com/cheggaaa/pb                            v1.0.29                                  go-module                    
github.com/choria-io/fisk                         v0.7.2                                   go-module                    
github.com/choria-io/scaffold                     v0.0.5                                   go-module                    
github.com/coreos/go-semver                       v0.3.1                                   go-module                    
github.com/coreos/go-systemd/v22                  v22.5.0                                  go-module                    
github.com/dimchansky/utfbom                      v1.1.1                                   go-module                    
github.com/dustin/go-humanize                     v1.0.1                                   go-module  (+1 duplicate)    
github.com/elliotchance/orderedmap                v1.8.0                                   go-module                    
github.com/emicklei/dot                           v1.9.1                                   go-module                    
github.com/expr-lang/expr                         v1.17.6                                  go-module                    
github.com/fatih/color                            v1.18.0                                  go-module  (+2 duplicates)   
github.com/fatih/structs                          v1.1.0                                   go-module                    
github.com/ghodss/yaml                            v1.0.0                                   go-module                    
github.com/go-ini/ini                             v1.67.0                                  go-module  (+1 duplicate)    
github.com/goccy/go-json                          v0.10.5                                  go-module  (+1 duplicate)    
github.com/goccy/go-yaml                          v1.18.0                                  go-module                    
github.com/gogo/protobuf                          v1.3.2                                   go-module                    
github.com/golang-jwt/jwt/v4                      v4.5.2                                   go-module                    
github.com/golang/protobuf                        v1.5.4                                   go-module                    
github.com/google/go-cmp                          v0.7.0                                   go-module                    
github.com/google/shlex                           v0.0.0-20191202100458-e7afc7fbc510       go-module  (+1 duplicate)    
github.com/google/uuid                            v1.6.0                                   go-module  (+1 duplicate)    
github.com/gosuri/uilive                          v0.0.4                                   go-module                    
github.com/gosuri/uiprogress                      v0.0.1                                   go-module                    
github.com/hashicorp/errwrap                      v1.1.0                                   go-module                    
github.com/hashicorp/go-multierror                v1.1.1                                   go-module                    
github.com/huandu/xstrings                        v1.5.0                                   go-module                    
github.com/inconshreveable/mousetrap              v1.1.0                                   go-module                    
github.com/jedib0t/go-pretty/v6                   v6.6.7                                   go-module                    
github.com/jedib0t/go-pretty/v6                   v6.6.8                                   go-module                    
github.com/jinzhu/copier                          v0.4.0                                   go-module                    
github.com/juju/ratelimit                         v1.0.2                                   go-module                    
github.com/kballard/go-shellquote                 v0.0.0-20180428030007-95032a82bc51       go-module                    
github.com/klauspost/compress                     v1.18.0                                  go-module  (+1 duplicate)    
github.com/klauspost/cpuid/v2                     v2.2.10                                  go-module                    
github.com/lestrrat-go/blackmagic                 v1.0.2                                   go-module                    
github.com/lestrrat-go/httpcc                     v1.0.1                                   go-module                    
github.com/lestrrat-go/httprc                     v1.0.6                                   go-module                    
github.com/lestrrat-go/iter                       v1.0.2                                   go-module                    
github.com/lestrrat-go/jwx/v2                     v2.1.4                                   go-module                    
github.com/lestrrat-go/option                     v1.0.1                                   go-module                    
github.com/lucasb-eyer/go-colorful                v1.2.0                                   go-module                    
github.com/magiconair/properties                  v1.8.10                                  go-module                    
github.com/mattn/go-colorable                     v0.1.14                                  go-module  (+2 duplicates)   
github.com/mattn/go-ieproxy                       v0.0.12                                  go-module                    
github.com/mattn/go-isatty                        v0.0.20                                  go-module  (+2 duplicates)   
github.com/mattn/go-runewidth                     v0.0.16                                  go-module  (+1 duplicate)    
github.com/matttproud/golang_protobuf_extensions  v1.0.4                                   go-module                    
github.com/mgutz/ansi                             v0.0.0-20200706080929-d51e80ef957d       go-module                    
github.com/mikefarah/yq/v4                        v4.49.1                                  go-module                    
github.com/minio/cli                              v1.24.2                                  go-module                    
github.com/minio/colorjson                        v1.0.8                                   go-module                    
github.com/minio/crc64nvme                        v1.0.1                                   go-module                    
github.com/minio/filepath                         v1.0.0                                   go-module                    
github.com/minio/highwayhash                      v1.0.3                                   go-module                    
github.com/minio/madmin-go/v3                     v3.0.107-0.20250415152934-4b504b82db63   go-module                    
github.com/minio/mc                               v0.0.0-20251106162529-77f82e18b540       go-module                    
github.com/minio/md5-simd                         v1.1.2                                   go-module                    
github.com/minio/minio-go/v7                      v7.0.90                                  go-module                    
github.com/minio/pkg/v3                           v3.1.0                                   go-module                    
github.com/minio/selfupdate                       v0.6.0                                   go-module                    
github.com/mitchellh/copystructure                v1.2.0                                   go-module                    
github.com/mitchellh/go-homedir                   v1.1.0                                   go-module  (+1 duplicate)    
github.com/mitchellh/reflectwalk                  v1.0.2                                   go-module                    
github.com/muesli/ansi                            v0.0.0-20230316100256-276c6243b2f6       go-module                    
github.com/muesli/cancelreader                    v0.2.2                                   go-module                    
github.com/muesli/duf                             UNKNOWN                                  go-module                    
github.com/muesli/reflow                          v0.3.0                                   go-module                    
github.com/muesli/termenv                         v0.16.0                                  go-module                    
github.com/munnerz/goautoneg                      v0.0.0-20191010083416-a7dc8b61c822       go-module  (+1 duplicate)    
github.com/nats-io/jsm.go                         v0.2.5-0.20250919104130-fa5c81909624     go-module                    
github.com/nats-io/jwt/v2                         v2.8.0                                   go-module                    
github.com/nats-io/nats-server/v2                 v2.12.0                                  go-module                    
github.com/nats-io/nats.go                        v1.45.0                                  go-module                    
github.com/nats-io/natscli                        v0.3.0                                   go-module                    
github.com/nats-io/nkeys                          v0.4.11                                  go-module                    
github.com/nats-io/nsc/v2                         v2.11.1                                  go-module                    
github.com/nats-io/nuid                           v1.0.1                                   go-module                    
github.com/nsf/termbox-go                         v1.1.1                                   go-module                    
github.com/olekukonko/tablewriter                 v0.0.5                                   go-module                    
github.com/pelletier/go-toml/v2                   v2.2.4                                   go-module                    
github.com/philhofer/fwd                          v1.1.3-0.20240916144458-20a13a1f6b7c     go-module                    
github.com/pkg/xattr                              v0.4.10                                  go-module                    
github.com/posener/complete                       v1.2.3                                   go-module                    
github.com/prometheus/client_golang               v1.21.1                                  go-module                    
github.com/prometheus/client_golang               v1.23.2                                  go-module                    
github.com/prometheus/client_model                v0.6.2                                   go-module  (+1 duplicate)    
github.com/prometheus/common                      v0.63.0                                  go-module                    
github.com/prometheus/common                      v0.66.1                                  go-module                    
github.com/prometheus/procfs                      v0.16.0                                  go-module                    
github.com/prometheus/procfs                      v0.17.0                                  go-module                    
github.com/prometheus/prom2json                   v1.4.2                                   go-module                    
github.com/prometheus/prometheus                  v0.303.0                                 go-module                    
github.com/rivo/uniseg                            v0.4.7                                   go-module  (+1 duplicate)    
github.com/rjeczalik/notify                       v0.9.3                                   go-module                    
github.com/rs/xid                                 v1.6.0                                   go-module                    
github.com/safchain/ethtool                       v0.5.10                                  go-module                    
github.com/santhosh-tekuri/jsonschema/v5          v5.3.1                                   go-module                    
github.com/secure-io/sio-go                       v0.3.1                                   go-module                    
github.com/shirou/gopsutil/v3                     v3.24.5                                  go-module                    
github.com/shopspring/decimal                     v1.4.0                                   go-module                    
github.com/spf13/cast                             v1.10.0                                  go-module                    
github.com/spf13/cobra                            v1.10.1                                  go-module                    
github.com/spf13/pflag                            v1.0.10                                  go-module                    
github.com/synadia-io/jwt-auth-builder.go         v0.0.9                                   go-module                    
github.com/synadia-io/orbit.go/jetstreamext       v0.1.0                                   go-module                    
github.com/synadia-io/orbit.go/natsext            v0.1.1                                   go-module                    
github.com/tidwall/gjson                          v1.18.0                                  go-module                    
github.com/tidwall/match                          v1.1.1                                   go-module                    
github.com/tidwall/pretty                         v1.2.1                                   go-module                    
github.com/tinylib/msgp                           v1.2.5                                   go-module                    
github.com/tklauser/go-sysconf                    v0.3.15                                  go-module                    
github.com/tklauser/numcpus                       v0.10.0                                  go-module                    
github.com/tylertreat/hdrhistogram-writer         v0.0.0-20210816161836-2e440612a39f       go-module                    
github.com/vbauerster/mpb/v8                      v8.9.3                                   go-module                    
github.com/xo/terminfo                            v0.0.0-20220910002029-abceb7e1c41e       go-module                    
github.com/yuin/gopher-lua                        v1.1.1                                   go-module                    
go                                                1.24.0                                   binary                       
go.etcd.io/etcd/api/v3                            v3.5.19                                  go-module                    
go.etcd.io/etcd/client/pkg/v3                     v3.5.19                                  go-module                    
go.etcd.io/etcd/client/v3                         v3.5.19                                  go-module                    
go.uber.org/multierr                              v1.11.0                                  go-module                    
go.uber.org/zap                                   v1.27.0                                  go-module                    
go.yaml.in/yaml/v2                                v2.4.3                                   go-module                    
go.yaml.in/yaml/v4                                v4.0.0-rc.3                              go-module                    
golang.org/x/crypto                               v0.42.0                                  go-module                    
golang.org/x/crypto                               v0.43.0                                  go-module                    
golang.org/x/exp                                  v0.0.0-20250911091902-df9299821621       go-module                    
golang.org/x/net                                  v0.44.0                                  go-module                    
golang.org/x/net                                  v0.46.0                                  go-module                    
golang.org/x/net                                  v0.47.0                                  go-module                    
golang.org/x/sync                                 v0.17.0                                  go-module                    
golang.org/x/sys                                  v0.36.0                                  go-module                    
golang.org/x/sys                                  v0.37.0                                  go-module                    
golang.org/x/sys                                  v0.38.0                                  go-module                    
golang.org/x/term                                 v0.35.0                                  go-module                    
golang.org/x/term                                 v0.36.0                                  go-module                    
golang.org/x/text                                 v0.29.0                                  go-module                    
golang.org/x/text                                 v0.30.0                                  go-module                    
golang.org/x/text                                 v0.31.0                                  go-module                    
golang.org/x/time                                 v0.13.0                                  go-module                    
google.golang.org/genproto/googleapis/api         v0.0.0-20250603155806-513f23925822       go-module                    
google.golang.org/genproto/googleapis/rpc         v0.0.0-20250728155136-f173205681a0       go-module                    
google.golang.org/grpc                            v1.74.2                                  go-module                    
google.golang.org/protobuf                        v1.36.6                                  go-module                    
google.golang.org/protobuf                        v1.36.9                                  go-module                    
gopkg.in/gizak/termui.v1                          v1.0.0-20151021151108-e62b5929642a       go-module                    
gopkg.in/op/go-logging.v1                         v1.0.0-20160211212156-b2cb9fa56473       go-module                    
gopkg.in/yaml.v2                                  v2.4.0                                   go-module  (+1 duplicate)    
gopkg.in/yaml.v3                                  v3.0.1                                   go-module  (+1 duplicate)    
gpgv                                              2.4.4-2ubuntu17.3                        deb                          
grep                                              3.11-4build1                             deb                          
gsettings-desktop-schemas                         46.1-0ubuntu1                            deb                          
gtk-update-icon-cache                             3.24.41-4ubuntu1.3                       deb                          
gzip                                              1.12-1ubuntu3.1                          deb                          
hicolor-icon-theme                                0.17-2                                   deb                          
hostname                                          3.23+nmu2ubuntu2                         deb                          
humanity-icon-theme                               0.6.16                                   deb                          
hyperfine                                         1.18.0-2build1                           deb                          
ibverbs-providers                                 50.0-2ubuntu0.2                          deb                          
inetutils-telnet                                  2:2.5-3ubuntu4                           deb                          
init-system-helpers                               1.66ubuntu1                              deb                          
iputils-ping                                      3:20240117-1ubuntu0.1                    deb                          
jq                                                1.7.1-3ubuntu0.24.04.1                   deb                          
krb5-locales                                      1.20.1-6ubuntu2.6                        deb                          
libacl1                                           2.3.2-1build1.1                          deb                          
libapparmor1                                      4.0.1really4.0.1-0ubuntu0.24.04.4        deb                          
libapt-pkg6.0t64                                  2.8.3                                    deb                          
libargon2-1                                       0~20190702+dfsg-4build1                  deb                          
libassuan0                                        2.5.6-1build1                            deb                          
libatk-bridge2.0-0t64                             2.52.0-1build1                           deb                          
libatk1.0-0t64                                    2.52.0-1build1                           deb                          
libatspi2.0-0t64                                  2.52.0-1build1                           deb                          
libattr1                                          1:2.5.2-1build1.1                        deb                          
libaudit-common                                   1:3.1.2-2.1build1.1                      deb                          
libaudit1                                         1:3.1.2-2.1build1.1                      deb                          
libavahi-client3                                  0.8-13ubuntu6                            deb                          
libavahi-common-data                              0.8-13ubuntu6                            deb                          
libavahi-common3                                  0.8-13ubuntu6                            deb                          
libblas3                                          3.12.0-3build1.1                         deb                          
libblkid1                                         2.39.3-9ubuntu6.3                        deb                          
libbrotli1                                        1.1.0-2build2                            deb                          
libbsd0                                           0.12.1-1build1.1                         deb                          
libbz2-1.0                                        1.0.8-5.1build0.1                        deb                          
libc-bin                                          2.39-0ubuntu8.6                          deb                          
libc6                                             2.39-0ubuntu8.6                          deb                          
libcairo-gobject2                                 1.18.0-3build1                           deb                          
libcairo2                                         1.18.0-3build1                           deb                          
libcap-ng0                                        0.8.4-2build2                            deb                          
libcap2                                           1:2.66-5ubuntu2.2                        deb                          
libcap2-bin                                       1:2.66-5ubuntu2.2                        deb                          
libcolord2                                        1.4.7-1build2                            deb                          
libcom-err2                                       1.47.0-2.4~exp1ubuntu4.1                 deb                          
libcommon-sense-perl                              3.75-3build3                             deb                          
libcrypt1                                         1:4.4.36-4build1                         deb                          
libcryptsetup12                                   2:2.7.0-1ubuntu4.2                       deb                          
libcups2t64                                       2.4.7-1.2ubuntu7.4                       deb                          
libcurl4t64                                       8.5.0-2ubuntu10.6                        deb                          
libdatrie1                                        0.2.13-3build1                           deb                          
libdb5.3t64                                       5.3.28+dfsg2-7                           deb                          
libdbus-1-3                                       1.14.10-4ubuntu4.1                       deb                          
libdconf1                                         0.40.0-4ubuntu0.1                        deb                          
libdebconfclient0                                 0.271ubuntu3                             deb                          
libdeflate0                                       1.19-1build1.1                           deb                          
libdevmapper1.02.1                                2:1.02.185-3ubuntu3.2                    deb                          
libedit2                                          3.1-20230828-1build1                     deb                          
libepoxy0                                         1.5.10-1build1                           deb                          
libexpat1                                         2.6.1-2ubuntu0.3                         deb                          
libext2fs2t64                                     1.47.0-2.4~exp1ubuntu4.1                 deb                          
libfdisk1                                         2.39.3-9ubuntu6.3                        deb                          
libffi8                                           3.4.6-1build1                            deb                          
libfontconfig1                                    2.15.0-1.1ubuntu2                        deb                          
libfreetype6                                      2.13.2+dfsg-1build3                      deb                          
libfribidi0                                       1.0.13-3build1                           deb                          
libgcc-s1                                         14.2.0-4ubuntu2~24.04                    deb                          
libgcrypt20                                       1.10.3-2build1                           deb                          
libgdbm-compat4t64                                1.23-5.1build1                           deb                          
libgdbm6t64                                       1.23-5.1build1                           deb                          
libgdk-pixbuf-2.0-0                               2.42.10+dfsg-3ubuntu3.2                  deb                          
libgdk-pixbuf2.0-bin                              2.42.10+dfsg-3ubuntu3.2                  deb                          
libgdk-pixbuf2.0-common                           2.42.10+dfsg-3ubuntu3.2                  deb                          
libgirepository-1.0-1                             1.80.1-1                                 deb                          
libglib2.0-0t64                                   2.80.0-6ubuntu3.4                        deb                          
libglib2.0-data                                   2.80.0-6ubuntu3.4                        deb                          
libgmp10                                          2:6.3.0+dfsg-2ubuntu6.1                  deb                          
libgnutls30t64                                    3.8.3-1.1ubuntu3.4                       deb                          
libgpg-error0                                     1.47-3build2.1                           deb                          
libgpm2                                           1.20.7-11                                deb                          
libgraphite2-3                                    1.3.14-2build1                           deb                          
libgssapi-krb5-2                                  1.20.1-6ubuntu2.6                        deb                          
libgtk-3-0t64                                     3.24.41-4ubuntu1.3                       deb                          
libgtk-3-bin                                      3.24.41-4ubuntu1.3                       deb                          
libgtk-3-common                                   3.24.41-4ubuntu1.3                       deb                          
libharfbuzz0b                                     8.3.0-2build2                            deb                          
libhogweed6t64                                    3.9.1-2.2build1.1                        deb                          
libibverbs1                                       50.0-2ubuntu0.2                          deb                          
libicu74                                          74.2-1ubuntu3.1                          deb                          
libidn2-0                                         2.3.7-2build1.1                          deb                          
libjansson4                                       2.14-2build2                             deb                          
libjbig0                                          2.1-6.1ubuntu2                           deb                          
libjpeg-turbo8                                    2.1.5-2ubuntu2                           deb                          
libjpeg8                                          8c-2ubuntu11                             deb                          
libjq1                                            1.7.1-3ubuntu0.24.04.1                   deb                          
libjson-c5                                        0.17-1build1                             deb                          
libjson-perl                                      4.10000-1                                deb                          
libjson-xs-perl                                   4.040-0ubuntu0.24.04.1                   deb                          
libk5crypto3                                      1.20.1-6ubuntu2.6                        deb                          
libkeyutils1                                      1.6.3-3build1                            deb                          
libkmod2                                          31+20240202-2ubuntu7.1                   deb                          
libkrb5-3                                         1.20.1-6ubuntu2.6                        deb                          
libkrb5support0                                   1.20.1-6ubuntu2.6                        deb                          
liblcms2-2                                        2.14-2build1                             deb                          
libldap-common                                    2.6.7+dfsg-1~exp1ubuntu8.2               deb                          
libldap2                                          2.6.7+dfsg-1~exp1ubuntu8.2               deb                          
liblerc4                                          4.0.0+ds-4ubuntu2                        deb                          
liblinear4                                        2.3.0+dfsg-5build1                       deb                          
libllvm17t64                                      1:17.0.6-9ubuntu1                        deb                          
liblmdb0                                          0.9.31-1build1                           deb                          
liblua5.4-0                                       5.4.6-3build2                            deb                          
liblz4-1                                          1.9.4-1build1.1                          deb                          
liblzma5                                          5.6.1+really5.4.5-1ubuntu0.2             deb                          
libmaxminddb0                                     1.9.1-1build1                            deb                          
libmd0                                            1.1.0-2build1.1                          deb                          
libmount1                                         2.39.3-9ubuntu6.3                        deb                          
libncurses6                                       6.4+20240113-1ubuntu2                    deb                          
libncursesw6                                      6.4+20240113-1ubuntu2                    deb                          
libnettle8t64                                     3.9.1-2.2build1.1                        deb                          
libnghttp2-14                                     1.59.0-1ubuntu0.2                        deb                          
libnl-3-200                                       3.7.0-0.3build1.1                        deb                          
libnl-route-3-200                                 3.7.0-0.3build1.1                        deb                          
libnpth0t64                                       1.6-3.1build1                            deb                          
libnss-systemd                                    255.4-1ubuntu8.11                        deb                          
libonig5                                          6.9.9-1build1                            deb                          
libp11-kit0                                       0.25.3-4ubuntu2.1                        deb                          
libpam-cap                                        1:2.66-5ubuntu2.2                        deb                          
libpam-modules                                    1.5.3-5ubuntu5.5                         deb                          
libpam-modules-bin                                1.5.3-5ubuntu5.5                         deb                          
libpam-runtime                                    1.5.3-5ubuntu5.5                         deb                          
libpam-systemd                                    255.4-1ubuntu8.11                        deb                          
libpam0g                                          1.5.3-5ubuntu5.5                         deb                          
libpango-1.0-0                                    1.52.1+ds-1build1                        deb                          
libpangocairo-1.0-0                               1.52.1+ds-1build1                        deb                          
libpangoft2-1.0-0                                 1.52.1+ds-1build1                        deb                          
libpcap0.8t64                                     1.10.4-4.1ubuntu3                        deb                          
libpcre2-8-0                                      10.42-4ubuntu2.1                         deb                          
libperl5.38t64                                    5.38.2-3.2ubuntu0.2                      deb                          
libpixman-1-0                                     0.42.2-1build1                           deb                          
libpng16-16t64                                    1.6.43-5build1                           deb                          
libpopt0                                          1.19+dfsg-1build1                        deb                          
libpq5                                            16.10-0ubuntu0.24.04.1                   deb                          
libproc2-0                                        2:4.0.4-4ubuntu3.2                       deb                          
libpsl5t64                                        0.21.2-1.1build1                         deb                          
libpython3-stdlib                                 3.12.3-0ubuntu2.1                        deb                          
libpython3.12-minimal                             3.12.3-1ubuntu0.8                        deb                          
libpython3.12-stdlib                              3.12.3-1ubuntu0.8                        deb                          
libreadline8t64                                   8.2-4build1                              deb                          
librsvg2-2                                        2.58.0+dfsg-1build1                      deb                          
librsvg2-common                                   2.58.0+dfsg-1build1                      deb                          
librtmp1                                          2.4+20151223.gitfa8646d.1-2build7        deb                          
libsasl2-2                                        2.1.28+dfsg1-5ubuntu3.1                  deb                          
libsasl2-modules                                  2.1.28+dfsg1-5ubuntu3.1                  deb                          
libsasl2-modules-db                               2.1.28+dfsg1-5ubuntu3.1                  deb                          
libseccomp2                                       2.5.5-1ubuntu3.1                         deb                          
libselinux1                                       3.5-2ubuntu2.1                           deb                          
libsemanage-common                                3.5-1build5                              deb                          
libsemanage2                                      3.5-1build5                              deb                          
libsensors-config                                 1:3.6.0-9build1                          deb                          
libsensors5                                       1:3.6.0-9build1                          deb                          
libsepol2                                         3.5-2build1                              deb                          
libsharpyuv0                                      1.3.2-0.4build3                          deb                          
libsmartcols1                                     2.39.3-9ubuntu6.3                        deb                          
libsqlite3-0                                      3.45.1-1ubuntu2.5                        deb                          
libss2                                            1.47.0-2.4~exp1ubuntu4.1                 deb                          
libssh-4                                          0.10.6-2ubuntu0.2                        deb                          
libssh2-1t64                                      1.11.0-4.1build2                         deb                          
libssl3t64                                        3.0.13-0ubuntu3.6                        deb                          
libstdc++6                                        14.2.0-4ubuntu2~24.04                    deb                          
libsystemd-shared                                 255.4-1ubuntu8.11                        deb                          
libsystemd0                                       255.4-1ubuntu8.11                        deb                          
libtasn1-6                                        4.19.0-3ubuntu0.24.04.1                  deb                          
libthai-data                                      0.1.29-2build1                           deb                          
libthai0                                          0.1.29-2build1                           deb                          
libtiff6                                          4.5.1+git230720-4ubuntu2.4               deb                          
libtinfo6                                         6.4+20240113-1ubuntu2                    deb                          
libtypes-serialiser-perl                          1.01-1                                   deb                          
libudev1                                          255.4-1ubuntu8.11                        deb                          
libunistring5                                     1.1-2build1.1                            deb                          
libuuid1                                          2.39.3-9ubuntu6.3                        deb                          
libuv1t64                                         1.48.0-1.1build1                         deb                          
libwayland-client0                                1.22.0-2.1build1                         deb                          
libwayland-cursor0                                1.22.0-2.1build1                         deb                          
libwayland-egl1                                   1.22.0-2.1build1                         deb                          
libwebp7                                          1.3.2-0.4build3                          deb                          
libx11-6                                          2:1.8.7-1build1                          deb                          
libx11-data                                       2:1.8.7-1build1                          deb                          
libxau6                                           1:1.0.9-1build6                          deb                          
libxcb-render0                                    1.15-1ubuntu2                            deb                          
libxcb-shm0                                       1.15-1ubuntu2                            deb                          
libxcb1                                           1.15-1ubuntu2                            deb                          
libxcomposite1                                    1:0.4.5-1build3                          deb                          
libxcursor1                                       1:1.2.1-1build1                          deb                          
libxdamage1                                       1:1.1.6-1build1                          deb                          
libxdmcp6                                         1:1.1.3-0ubuntu6                         deb                          
libxext6                                          2:1.3.4-1build2                          deb                          
libxfixes3                                        1:6.0.0-2build1                          deb                          
libxi6                                            2:1.8.1-1build1                          deb                          
libxinerama1                                      2:1.1.4-3build1                          deb                          
libxkbcommon0                                     1.6.0-1build1                            deb                          
libxml2                                           2.9.14+dfsg-1.3ubuntu3.6                 deb                          
libxrandr2                                        2:1.5.2-2build1                          deb                          
libxrender1                                       1:0.9.10-1.1build1                       deb                          
libxslt1.1                                        1.1.39-0exp1ubuntu0.24.04.2              deb                          
libxtst6                                          2:1.2.3-1.1build1                        deb                          
libxxhash0                                        0.8.2-2build1                            deb                          
libzstd1                                          1.5.5+dfsg2-2build1.1                    deb                          
locales                                           2.39-0ubuntu8.6                          deb                          
login                                             1:4.13+dfsg1-4ubuntu3.2                  deb                          
logrotate                                         3.21.0-2build1                           deb                          
logsave                                           1.47.0-2.4~exp1ubuntu4.1                 deb                          
mawk                                              1.3.4.20240123-1build1                   deb                          
media-types                                       10.1.0                                   deb                          
mount                                             2.39.3-9ubuntu6.3                        deb                          
mtr                                               0.95-1.1ubuntu0.1                        deb                          
ncurses-base                                      6.4+20240113-1ubuntu2                    deb                          
ncurses-bin                                       6.4+20240113-1ubuntu2                    deb                          
netbase                                           6.4                                      deb                          
netcat-traditional                                1.10-48                                  deb                          
networkd-dispatcher                               2.2.4-1                                  deb                          
nmap                                              7.94+git20230807.3be01efb1+dfsg-3build2  deb                          
nmap-common                                       7.94+git20230807.3be01efb1+dfsg-3build2  deb                          
openssl                                           3.0.13-0ubuntu3.6                        deb                          
passwd                                            1:4.13+dfsg1-4ubuntu3.2                  deb                          
perl                                              5.38.2-3.2ubuntu0.2                      deb                          
perl-base                                         5.38.2-3.2ubuntu0.2                      deb                          
perl-modules-5.38                                 5.38.2-3.2ubuntu0.2                      deb                          
postgresql                                        16+257build1.1                           deb                          
postgresql-16                                     16.10-0ubuntu0.24.04.1                   deb                          
postgresql-client-16                              16.10-0ubuntu0.24.04.1                   deb                          
postgresql-client-common                          257build1.1                              deb                          
postgresql-common                                 257build1.1                              deb                          
procps                                            2:4.0.4-4ubuntu3.2                       deb                          
prometheus-io                                     0.303.0                                  npm                          
publicsuffix                                      20231001.0357-0.1                        deb                          
pygobject                                         3.48.2                                   python                       
python3                                           3.12.3-0ubuntu2.1                        deb                          
python3-dbus                                      1.3.2-5build3                            deb                          
python3-gi                                        3.48.2-1                                 deb                          
python3-minimal                                   3.12.3-0ubuntu2.1                        deb                          
python3.12                                        3.12.3-1ubuntu0.8                        deb                          
python3.12-minimal                                3.12.3-1ubuntu0.8                        deb                          
readline-common                                   8.2-4build1                              deb                          
rsync                                             3.2.7-1ubuntu1.2                         deb                          
sed                                               4.9-2build1                              deb                          
sensible-utils                                    0.0.22                                   deb                          
session-migration                                 0.3.9build1                              deb                          
shared-mime-info                                  2.4-4                                    deb                          
ssl-cert                                          1.1.2ubuntu1                             deb                          
stdlib                                            go1.17                                   go-module                    
stdlib                                            go1.22.2                                 go-module                    
stdlib                                            go1.24.0                                 go-module  (+21 duplicates)  
stdlib                                            go1.25.4                                 go-module                    
sysstat                                           12.6.1-2                                 deb                          
systemd                                           255.4-1ubuntu8.11                        deb                          
systemd-dev                                       255.4-1ubuntu8.11                        deb                          
systemd-resolved                                  255.4-1ubuntu8.11                        deb                          
systemd-sysv                                      255.4-1ubuntu8.11                        deb                          
systemd-timesyncd                                 255.4-1ubuntu8.11                        deb                          
sysvinit-utils                                    3.08-6ubuntu3                            deb                          
tar                                               1.35+dfsg-3build1                        deb                          
tcpdump                                           4.99.4-3ubuntu4.24.04.1                  deb                          
telnet                                            0.17+2.5-3ubuntu4                        deb                          
traceroute                                        1:2.1.5-1                                deb                          
tzdata                                            2025b-0ubuntu0.24.04.1                   deb                          
ubuntu-keyring                                    2023.11.28.1                             deb                          
ubuntu-mono                                       24.04-0ubuntu1                           deb                          
ucf                                               3.0043+nmu1                              deb                          
unminimize                                        0.2.1                                    deb                          
unzip                                             6.0-28ubuntu4.1                          deb                          
util-linux                                        2.39.3-9ubuntu6.3                        deb                          
wget                                              1.21.4-1ubuntu4.1                        deb                          
x11-common                                        1:7.7+23ubuntu3                          deb                          
xdg-user-dirs                                     0.18-1build1                             deb                          
xkb-data                                          2.41-2ubuntu1.1                          deb                          
xz-utils                                          5.6.1+really5.4.5-1ubuntu0.2             deb                          
zlib1g                                            1:1.3.dfsg-3.1ubuntu2.1                  deb
```

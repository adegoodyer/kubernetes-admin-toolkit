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

Default >Uses namespace so change if required

$()$(
  bash
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
)$()

### Docker
$()$(
  bash
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
  d stop kubernetes-admin-toolkit &&
    d rm kubernetes-admin-toolkit
)$()

## Security Scan
```bash
NAME                    INSTALLED                    FIXED-IN                       TYPE       VULNERABILITY        SEVERITY    EPSS%  RISK  
libpq5                  16.4-0ubuntu0.24.04.2        16.8-0ubuntu0.24.04.1          deb        CVE-2025-1094        Medium      99.14   41.0  
postgresql-16           16.4-0ubuntu0.24.04.2        16.8-0ubuntu0.24.04.1          deb        CVE-2025-1094        Medium      99.14   41.0  
postgresql-client-16    16.4-0ubuntu0.24.04.2        16.8-0ubuntu0.24.04.1          deb        CVE-2025-1094        Medium      99.14   41.0  
libcups2t64             2.4.7-1.2ubuntu7.2           2.4.7-1.2ubuntu7.3             deb        CVE-2024-47175       Medium      95.97   13.0  
rsync                   3.2.7-1ubuntu1               3.2.7-1ubuntu1.1               deb        CVE-2024-12084       High        94.39   12.0  
libcapnp-1.0.1          1.0.1-4                                                     deb        CVE-2023-48230       Medium      88.08    2.1  
libpococrypto80t64      1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpocodata80t64        1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpocodataodbc80t64    1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpocofoundation80t64  1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpocojson80t64        1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpocomongodb80t64     1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpoconet80t64         1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpoconetssl80t64      1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpocoutil80t64        1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
libpocoxml80t64         1.11.0-4.1build2                                            deb        CVE-2021-46143       Medium      87.68    1.9  
login                   1:4.13+dfsg1-4ubuntu3                                       deb        CVE-2024-56433       Low         87.97    1.2  
passwd                  1:4.13+dfsg1-4ubuntu3                                       deb        CVE-2024-56433       Low         87.97    1.2  
rsync                   3.2.7-1ubuntu1               3.2.7-1ubuntu1.1               deb        CVE-2024-12085       Medium      79.61    0.7  
libpq5                  16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10979       Medium      77.31    0.6  
postgresql-16           16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10979       Medium      77.31    0.6  
postgresql-client-16    16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10979       Medium      77.31    0.6  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.5              deb        CVE-2025-0938        Medium      76.13    0.5  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.5              deb        CVE-2025-0938        Medium      76.13    0.5  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.5              deb        CVE-2025-0938        Medium      76.13    0.5  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.5              deb        CVE-2025-0938        Medium      76.13    0.5  
krb5-locales            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.3              deb        CVE-2024-3596        Medium      73.44    0.4  
libgssapi-krb5-2        1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.3              deb        CVE-2024-3596        Medium      73.44    0.4  
libk5crypto3            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.3              deb        CVE-2024-3596        Medium      73.44    0.4  
libkrb5-3               1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.3              deb        CVE-2024-3596        Medium      73.44    0.4  
libkrb5support0         1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.3              deb        CVE-2024-3596        Medium      73.44    0.4  
stdlib                  go1.22.2                     1.21.10, *1.22.3               go-module  CVE-2024-24787       Medium      71.18    0.4  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6232        Medium      73.02    0.4  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6232        Medium      73.02    0.4  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6232        Medium      73.02    0.4  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6232        Medium      73.02    0.4  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2024-6873        Medium      67.01    0.3  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2024-6873        Medium      67.01    0.3  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2023-48298       Medium      63.30    0.2  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2023-48298       Medium      63.30    0.2  
libexpat1               2.6.1-2build1                2.6.1-2ubuntu0.3               deb        CVE-2024-8176        Medium      59.65    0.2  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2023-47118       Medium      58.89    0.2  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2023-47118       Medium      58.89    0.2  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2023-48704       Medium      57.50    0.2  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2023-48704       Medium      57.50    0.2  
libgnutls30t64          3.8.3-1.1ubuntu3.1           3.8.3-1.1ubuntu3.3             deb        CVE-2024-12243       Medium      54.69    0.2  
stdlib                  go1.22.2                     1.21.11, *1.22.4               go-module  CVE-2024-24790       Critical    39.34    0.2  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2022-44010       Medium      53.90    0.2  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2022-44010       Medium      53.90    0.2  
stdlib                  go1.22.2                     1.21.12, *1.22.5               go-module  CVE-2024-24791       High        42.67    0.1  
gir1.2-glib-2.0         2.80.0-6ubuntu3.1            2.80.0-6ubuntu3.2              deb        CVE-2024-52533       Medium      49.18    0.1  
libglib2.0-0t64         2.80.0-6ubuntu3.1            2.80.0-6ubuntu3.2              deb        CVE-2024-52533       Medium      49.18    0.1  
libglib2.0-data         2.80.0-6ubuntu3.1            2.80.0-6ubuntu3.2              deb        CVE-2024-52533       Medium      49.18    0.1  
wget                    1.21.4-1ubuntu4.1                                           deb        CVE-2024-10524       Low         58.32    0.1  
rsync                   3.2.7-1ubuntu1               3.2.7-1ubuntu1.1               deb        CVE-2024-12087       Medium      44.77    0.1  
rsync                   3.2.7-1ubuntu1               3.2.7-1ubuntu1.1               deb        CVE-2024-12088       Medium      44.77    0.1  
libperl5.38t64          5.38.2-3.2build2             5.38.2-3.2ubuntu0.1            deb        CVE-2024-56406       Medium      43.83    0.1  
perl                    5.38.2-3.2build2             5.38.2-3.2ubuntu0.1            deb        CVE-2024-56406       Medium      43.83    0.1  
perl-base               5.38.2-3.2build2             5.38.2-3.2ubuntu0.1            deb        CVE-2024-56406       Medium      43.83    0.1  
perl-modules-5.38       5.38.2-3.2build2             5.38.2-3.2ubuntu0.1            deb        CVE-2024-56406       Medium      43.83    0.1  
libssl3t64              3.0.13-0ubuntu3.4            3.0.13-0ubuntu3.5              deb        CVE-2024-9143        Low         53.10  < 0.1  
openssl                 3.0.13-0ubuntu3.4            3.0.13-0ubuntu3.5              deb        CVE-2024-9143        Low         53.10  < 0.1  
libc-bin                2.39-0ubuntu8.3              2.39-0ubuntu8.4                deb        CVE-2025-0395        Medium      39.85  < 0.1  
libc6                   2.39-0ubuntu8.3              2.39-0ubuntu8.4                deb        CVE-2025-0395        Medium      39.85  < 0.1  
locales                 2.39-0ubuntu8.3              2.39-0ubuntu8.4                deb        CVE-2025-0395        Medium      39.85  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-7592        Low         51.37  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-7592        Low         51.37  < 0.1  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-7592        Low         51.37  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-7592        Low         51.37  < 0.1  
stdlib                  go1.22.2                     *1.22.7, 1.23.1                go-module  CVE-2024-34156       High        30.31  < 0.1  
stdlib                  go1.22.5                     *1.22.7, 1.23.1                go-module  CVE-2024-34156       High        30.31  < 0.1  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2024-41436       Medium      38.19  < 0.1  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2024-41436       Medium      38.19  < 0.1  
rsync                   3.2.7-1ubuntu1               3.2.7-1ubuntu1.1               deb        CVE-2024-12086       Medium      37.05  < 0.1  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2025-1385        Medium      36.76  < 0.1  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2025-1385        Medium      36.76  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21196       Medium      36.41  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21230       Medium      36.41  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.4              deb        CVE-2024-12254       Medium      35.94  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.4              deb        CVE-2024-12254       Medium      35.94  < 0.1  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.4              deb        CVE-2024-12254       Medium      35.94  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.4              deb        CVE-2024-12254       Medium      35.94  < 0.1  
wget                    1.21.4-1ubuntu4.1                                           deb        CVE-2021-31879       Medium      34.74  < 0.1  
curl                    8.5.0-2ubuntu10.3            8.5.0-2ubuntu10.5              deb        CVE-2024-9681        Low         44.76  < 0.1  
libcurl4t64             8.5.0-2ubuntu10.3            8.5.0-2ubuntu10.5              deb        CVE-2024-9681        Low         44.76  < 0.1  
libpam-modules          1.5.3-5ubuntu5.1                                            deb        CVE-2024-10963       Medium      33.86  < 0.1  
libpam-modules-bin      1.5.3-5ubuntu5.1                                            deb        CVE-2024-10963       Medium      33.86  < 0.1  
libpam-runtime          1.5.3-5ubuntu5.1                                            deb        CVE-2024-10963       Medium      33.86  < 0.1  
libpam0g                1.5.3-5ubuntu5.1                                            deb        CVE-2024-10963       Medium      33.86  < 0.1  
liblzma5                5.6.1+really5.4.5-1build0.1  5.6.1+really5.4.5-1ubuntu0.2   deb        CVE-2025-31115       Medium      33.56  < 0.1  
xz-utils                5.6.1+really5.4.5-1build0.1  5.6.1+really5.4.5-1ubuntu0.2   deb        CVE-2025-31115       Medium      33.56  < 0.1  
libpcre3                2:8.39-15build1                                             deb        CVE-2019-20838       Low         43.08  < 0.1  
curl                    8.5.0-2ubuntu10.3            8.5.0-2ubuntu10.4              deb        CVE-2024-8096        Medium      32.31  < 0.1  
libcurl4t64             8.5.0-2ubuntu10.3            8.5.0-2ubuntu10.4              deb        CVE-2024-8096        Medium      32.31  < 0.1  
libcairo-gobject2       1.18.0-3build1                                              deb        CVE-2018-18064       Low         42.16  < 0.1  
libcairo2               1.18.0-3build1                                              deb        CVE-2018-18064       Low         42.16  < 0.1  
libgcrypt20             1.10.3-2build1                                              deb        CVE-2024-2236        Low         42.16  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2023-27043       Medium      31.42  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2023-27043       Medium      31.42  < 0.1  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2023-27043       Medium      31.42  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2023-27043       Medium      31.42  < 0.1  
libcairo-gobject2       1.18.0-3build1                                              deb        CVE-2017-9814        Low         41.44  < 0.1  
libcairo2               1.18.0-3build1                                              deb        CVE-2017-9814        Low         41.44  < 0.1  
libexpat1               2.6.1-2build1                2.6.1-2ubuntu0.1               deb        CVE-2024-45492       Medium      31.14  < 0.1  
libjpeg-turbo8          2.1.5-2ubuntu2                                              deb        CVE-2018-10126       Low         40.92  < 0.1  
libpq5                  16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10978       Medium      29.27  < 0.1  
postgresql-16           16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10978       Medium      29.27  < 0.1  
postgresql-client-16    16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10978       Medium      29.27  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21193       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21194       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21197       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21198       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21199       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21201       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21219       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21236       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21239       Medium      29.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21241       Medium      29.17  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1                                           deb        CVE-2025-1795        Low         38.88  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1                                           deb        CVE-2025-1795        Low         38.88  < 0.1  
python3.12              3.12.3-1ubuntu0.1                                           deb        CVE-2025-1795        Low         38.88  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1                                           deb        CVE-2025-1795        Low         38.88  < 0.1  
stdlib                  go1.22.2                     1.22.3                         go-module  CVE-2024-24788       Medium      26.72  < 0.1  
libssl3t64              3.0.13-0ubuntu3.4                                           deb        CVE-2024-41996       Low         37.59  < 0.1  
openssl                 3.0.13-0ubuntu3.4                                           deb        CVE-2024-41996       Low         37.59  < 0.1  
libcairo-gobject2       1.18.0-3build1                                              deb        CVE-2019-6461        Low         37.31  < 0.1  
libcairo2               1.18.0-3build1                                              deb        CVE-2019-6461        Low         37.31  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-8088        Medium      27.41  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-8088        Medium      27.41  < 0.1  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-8088        Medium      27.41  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-8088        Medium      27.41  < 0.1  
libavahi-client3        0.8-13ubuntu6                                               deb        CVE-2024-52616       Medium      26.63  < 0.1  
libavahi-common-data    0.8-13ubuntu6                                               deb        CVE-2024-52616       Medium      26.63  < 0.1  
libavahi-common3        0.8-13ubuntu6                                               deb        CVE-2024-52616       Medium      26.63  < 0.1  
libpococrypto80t64      1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpocodata80t64        1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpocodataodbc80t64    1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpocofoundation80t64  1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpocojson80t64        1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpocomongodb80t64     1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpoconet80t64         1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpoconetssl80t64      1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpocoutil80t64        1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
libpocoxml80t64         1.11.0-4.1build2                                            deb        CVE-2023-52389       Medium      26.42  < 0.1  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2022-44011       Medium      26.16  < 0.1  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2022-44011       Medium      26.16  < 0.1  
libsqlite3-0            3.45.1-1ubuntu2                                             deb        CVE-2025-3277        Medium      26.06  < 0.1  
libpq5                  16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10976       Medium      25.96  < 0.1  
postgresql-16           16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10976       Medium      25.96  < 0.1  
postgresql-client-16    16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10976       Medium      25.96  < 0.1  
libxml2                 2.9.14+dfsg-1.3ubuntu3       2.9.14+dfsg-1.3ubuntu3.1       deb        CVE-2024-34459       Low         35.17  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6923        Medium      25.25  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6923        Medium      25.25  < 0.1  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6923        Medium      25.25  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.2              deb        CVE-2024-6923        Medium      25.25  < 0.1  
stdlib                  go1.22.2                     *1.22.7, 1.23.1                go-module  CVE-2024-34158       High        16.91  < 0.1  
stdlib                  go1.22.5                     *1.22.7, 1.23.1                go-module  CVE-2024-34158       High        16.91  < 0.1  
bind9-dnsutils          1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-11187       Medium      24.65  < 0.1  
bind9-host              1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-11187       Medium      24.65  < 0.1  
bind9-libs              1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-11187       Medium      24.65  < 0.1  
dnsutils                1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-11187       Medium      24.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21500       Medium      23.98  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21501       Medium      23.98  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21518       Medium      23.98  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21522       Medium      23.98  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21212       Medium      23.86  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21237       Medium      23.86  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2025-21521       Medium      23.75  < 0.1  
libtasn1-6              4.19.0-3build1               4.19.0-3ubuntu0.24.04.1        deb        CVE-2024-12133       Medium      23.67  < 0.1  
unzip                   6.0-28ubuntu4                6.0-28ubuntu4.1                deb        CVE-2021-4217        Low         33.22  < 0.1  
curl                    8.5.0-2ubuntu10.3            8.5.0-2ubuntu10.6              deb        CVE-2024-11053       Low         31.71  < 0.1  
libcurl4t64             8.5.0-2ubuntu10.3            8.5.0-2ubuntu10.6              deb        CVE-2024-11053       Low         31.71  < 0.1  
bind9-dnsutils          1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-12705       Medium      21.35  < 0.1  
bind9-host              1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-12705       Medium      21.35  < 0.1  
bind9-libs              1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-12705       Medium      21.35  < 0.1  
dnsutils                1:9.18.28-0ubuntu0.24.04.1   1:9.18.30-0ubuntu0.24.04.2     deb        CVE-2024-12705       Medium      21.35  < 0.1  
libcairo-gobject2       1.18.0-3build1                                              deb        CVE-2017-7475        Low         30.83  < 0.1  
libcairo2               1.18.0-3build1                                              deb        CVE-2017-7475        Low         30.83  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21231       Low         30.77  < 0.1  
stdlib                  go1.22.2                     *1.22.7, 1.23.1                go-module  CVE-2024-34155       Medium      22.20  < 0.1  
stdlib                  go1.22.5                     *1.22.7, 1.23.1                go-module  CVE-2024-34155       Medium      22.20  < 0.1  
libpq5                  16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10977       Medium      20.82  < 0.1  
postgresql-16           16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10977       Medium      20.82  < 0.1  
postgresql-client-16    16.4-0ubuntu0.24.04.2        16.6-0ubuntu0.24.04.1          deb        CVE-2024-10977       Medium      20.82  < 0.1  
libavahi-client3        0.8-13ubuntu6                                               deb        CVE-2024-52615       Medium      20.80  < 0.1  
libavahi-common-data    0.8-13ubuntu6                                               deb        CVE-2024-52615       Medium      20.80  < 0.1  
libavahi-common3        0.8-13ubuntu6                                               deb        CVE-2024-52615       Medium      20.80  < 0.1  
libexpat1               2.6.1-2build1                2.6.1-2ubuntu0.1               deb        CVE-2024-45491       Medium      19.68  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21490       Medium      18.62  < 0.1  
gir1.2-glib-2.0         2.80.0-6ubuntu3.1                                           deb        CVE-2025-3360        Low         27.04  < 0.1  
libglib2.0-0t64         2.80.0-6ubuntu3.1                                           deb        CVE-2025-3360        Low         27.04  < 0.1  
libglib2.0-data         2.80.0-6ubuntu3.1                                           deb        CVE-2025-3360        Low         27.04  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21491       Medium      16.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21503       Medium      16.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2025-21504       Medium      16.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21505       Medium      16.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2025-21525       Medium      16.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21529       Medium      16.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2025-21534       Medium      16.65  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2025-21536       Medium      16.65  < 0.1  
gir1.2-glib-2.0         2.80.0-6ubuntu3.1                                           deb        CVE-2025-4373        Medium      15.94  < 0.1  
libglib2.0-0t64         2.80.0-6ubuntu3.1                                           deb        CVE-2025-4373        Medium      15.94  < 0.1  
libglib2.0-data         2.80.0-6ubuntu3.1                                           deb        CVE-2025-4373        Medium      15.94  < 0.1  
libxml2                 2.9.14+dfsg-1.3ubuntu3       2.9.14+dfsg-1.3ubuntu3.2       deb        CVE-2025-27113       Medium      15.48  < 0.1  
libpq5                  16.4-0ubuntu0.24.04.2        16.9-0ubuntu0.24.04.1          deb        CVE-2025-4207        Medium      15.38  < 0.1  
postgresql-16           16.4-0ubuntu0.24.04.2        16.9-0ubuntu0.24.04.1          deb        CVE-2025-4207        Medium      15.38  < 0.1  
postgresql-client-16    16.4-0ubuntu0.24.04.2        16.9-0ubuntu0.24.04.1          deb        CVE-2025-4207        Medium      15.38  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21519       Medium      15.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21523       Medium      15.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21555       Medium      15.17  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21559       Medium      15.17  < 0.1  
libpcre3                2:8.39-15build1                                             deb        CVE-2017-11164       Negligible  63.76  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30681       Medium      14.26  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30704       Medium      14.26  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30705       Medium      14.26  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30715       Medium      14.26  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21574       Medium      13.75  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21575       Medium      13.75  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21577       Medium      13.75  < 0.1  
libsqlite3-0            3.45.1-1ubuntu2                                             deb        CVE-2025-29088       Medium      13.63  < 0.1  
libc-bin                2.39-0ubuntu8.3                                             deb        CVE-2025-4802        Medium      13.05  < 0.1  
libc6                   2.39-0ubuntu8.3                                             deb        CVE-2025-4802        Medium      13.05  < 0.1  
locales                 2.39-0ubuntu8.3                                             deb        CVE-2025-4802        Medium      13.05  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21579       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21580       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21581       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21584       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-21585       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30683       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30684       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30685       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30689       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30693       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30695       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30696       Medium      12.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30699       Medium      12.82  < 0.1  
libsqlite3-0            3.45.1-1ubuntu2                                             deb        CVE-2025-29087       Medium      12.72  < 0.1  
libexpat1               2.6.1-2build1                2.6.1-2ubuntu0.1               deb        CVE-2024-45490       Medium      12.69  < 0.1  
traceroute              1:2.1.5-1                                                   deb        CVE-2023-46316       Medium      12.64  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30682       Medium      12.38  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30687       Medium      12.38  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30688       Medium      12.38  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30722       Medium      11.37  < 0.1  
coreutils               9.4-3ubuntu6                                                deb        CVE-2016-2781        Low         20.75  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.3              deb        CVE-2024-9287        Medium      10.63  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.3              deb        CVE-2024-9287        Medium      10.63  < 0.1  
python3.12              3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.3              deb        CVE-2024-9287        Medium      10.63  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1            3.12.3-1ubuntu0.3              deb        CVE-2024-9287        Medium      10.63  < 0.1  
curl                    8.5.0-2ubuntu10.3                                           deb        CVE-2025-0167        Low         19.80  < 0.1  
libcurl4t64             8.5.0-2ubuntu10.3                                           deb        CVE-2025-0167        Low         19.80  < 0.1  
libcairo-gobject2       1.18.0-3build1                                              deb        CVE-2019-6462        Low         19.39  < 0.1  
libcairo2               1.18.0-3build1                                              deb        CVE-2019-6462        Low         19.39  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21546       Medium       8.30  < 0.1  
stdlib                  go1.22.2                     *1.23.8, 1.24.2                go-module  CVE-2025-22871       Critical     3.13  < 0.1  
stdlib                  go1.22.5                     *1.23.8, 1.24.2                go-module  CVE-2025-22871       Critical     3.13  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21497       Medium       7.82  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30703       Medium       7.68  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.41-0ubuntu0.24.04.1        deb        CVE-2025-21540       Medium       7.28  < 0.1  
libexpat1               2.6.1-2build1                2.6.1-2ubuntu0.2               deb        CVE-2024-50602       Medium       7.27  < 0.1  
iputils-ping            3:20240117-1build1                                          deb        CVE-2025-47268       Low         15.96  < 0.1  
libpixman-1-0           0.42.2-1build1                                              deb        CVE-2023-37769       Medium       7.03  < 0.1  
stdlib                  go1.22.2                     *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45336       Medium       5.96  < 0.1  
stdlib                  go1.22.5                     *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45336       Medium       5.96  < 0.1  
libllvm17t64            1:17.0.6-9ubuntu1                                           deb        CVE-2024-7883        Low         14.33  < 0.1  
krb5-locales            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26461       Low         13.55  < 0.1  
libgssapi-krb5-2        1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26461       Low         13.55  < 0.1  
libk5crypto3            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26461       Low         13.55  < 0.1  
libkrb5-3               1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26461       Low         13.55  < 0.1  
libkrb5support0         1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26461       Low         13.55  < 0.1  
krb5-locales            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26462       Medium       5.58  < 0.1  
libgssapi-krb5-2        1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26462       Medium       5.58  < 0.1  
libk5crypto3            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26462       Medium       5.58  < 0.1  
libkrb5-3               1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26462       Medium       5.58  < 0.1  
libkrb5support0         1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26462       Medium       5.58  < 0.1  
libpam-modules          1.5.3-5ubuntu5.1                                            deb        CVE-2024-10041       Medium       5.49  < 0.1  
libpam-modules-bin      1.5.3-5ubuntu5.1                                            deb        CVE-2024-10041       Medium       5.49  < 0.1  
libpam-runtime          1.5.3-5ubuntu5.1                                            deb        CVE-2024-10041       Medium       5.49  < 0.1  
libpam0g                1.5.3-5ubuntu5.1                                            deb        CVE-2024-10041       Medium       5.49  < 0.1  
rsync                   3.2.7-1ubuntu1               3.2.7-1ubuntu1.1               deb        CVE-2024-12747       Medium       5.10  < 0.1  
libxml2                 2.9.14+dfsg-1.3ubuntu3       2.9.14+dfsg-1.3ubuntu3.1       deb        CVE-2022-49043       Medium       5.08  < 0.1  
golang.org/x/net        v0.27.0                      0.38.0                         go-module  GHSA-vvgc-356p-c3xw  Medium       5.03  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2024-21213       Medium       4.93  < 0.1  
libcap2                 1:2.66-5ubuntu2              1:2.66-5ubuntu2.2              deb        CVE-2025-1390        Medium       3.91  < 0.1  
libcap2-bin             1:2.66-5ubuntu2              1:2.66-5ubuntu2.2              deb        CVE-2025-1390        Medium       3.91  < 0.1  
libpam-cap              1:2.66-5ubuntu2              1:2.66-5ubuntu2.2              deb        CVE-2025-1390        Medium       3.91  < 0.1  
x11-common              1:7.7+23ubuntu3                                             deb        CVE-2023-5574        Low          8.77  < 0.1  
libc-bin                2.39-0ubuntu8.3                                             deb        CVE-2016-20013       Negligible  42.77  < 0.1  
libc6                   2.39-0ubuntu8.3                                             deb        CVE-2016-20013       Negligible  42.77  < 0.1  
locales                 2.39-0ubuntu8.3                                             deb        CVE-2016-20013       Negligible  42.77  < 0.1  
libxml2                 2.9.14+dfsg-1.3ubuntu3       2.9.14+dfsg-1.3ubuntu3.3       deb        CVE-2025-32415       Medium       3.76  < 0.1  
libxml2                 2.9.14+dfsg-1.3ubuntu3       2.9.14+dfsg-1.3ubuntu3.3       deb        CVE-2025-32414       Medium       3.61  < 0.1  
stdlib                  go1.22.2                     *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45341       Medium       3.10  < 0.1  
stdlib                  go1.22.5                     *1.22.11, 1.23.5, 1.24.0-rc.2  go-module  CVE-2024-45341       Medium       3.10  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.40-0ubuntu0.24.04.1        deb        CVE-2025-21494       Medium       2.72  < 0.1  
libssl3t64              3.0.13-0ubuntu3.4            3.0.13-0ubuntu3.5              deb        CVE-2024-13176       Low          4.97  < 0.1  
openssl                 3.0.13-0ubuntu3.4            3.0.13-0ubuntu3.5              deb        CVE-2024-13176       Low          4.97  < 0.1  
libpython3.12-minimal   3.12.3-1ubuntu0.1                                           deb        CVE-2025-4516        Medium       1.63  < 0.1  
libpython3.12-stdlib    3.12.3-1ubuntu0.1                                           deb        CVE-2025-4516        Medium       1.63  < 0.1  
python3.12              3.12.3-1ubuntu0.1                                           deb        CVE-2025-4516        Medium       1.63  < 0.1  
python3.12-minimal      3.12.3-1ubuntu0.1                                           deb        CVE-2025-4516        Medium       1.63  < 0.1  
libmysqlclient21        8.0.39-0ubuntu0.24.04.2      8.0.42-0ubuntu0.24.04.1        deb        CVE-2025-30721       Medium       1.63  < 0.1  
stdlib                  go1.22.2                     1.21.11, *1.22.4               go-module  CVE-2024-24789       Medium       1.11  < 0.1  
golang.org/x/net        v0.27.0                      0.36.0                         go-module  GHSA-qxp5-gwg8-xv66  Medium       1.17  < 0.1  
gpgv                    2.4.4-2ubuntu17              2.4.4-2ubuntu17.2              deb        CVE-2025-30258       Medium       0.78  < 0.1  
krb5-locales            1.20.1-6ubuntu2.1                                           deb        CVE-2025-3576        Medium       0.75  < 0.1  
libgssapi-krb5-2        1.20.1-6ubuntu2.1                                           deb        CVE-2025-3576        Medium       0.75  < 0.1  
libk5crypto3            1.20.1-6ubuntu2.1                                           deb        CVE-2025-3576        Medium       0.75  < 0.1  
libkrb5-3               1.20.1-6ubuntu2.1                                           deb        CVE-2025-3576        Medium       0.75  < 0.1  
libkrb5support0         1.20.1-6ubuntu2.1                                           deb        CVE-2025-3576        Medium       0.75  < 0.1  
libxslt1.1              1.1.39-0exp1build1           1.1.39-0exp1ubuntu0.24.04.2    deb        CVE-2025-24855       Medium       0.54  < 0.1  
stdlib                  go1.22.2                     *1.22.12, 1.23.6, 1.24.0-rc.3  go-module  CVE-2025-22866       Medium       0.56  < 0.1  
stdlib                  go1.22.5                     *1.22.12, 1.23.6, 1.24.0-rc.3  go-module  CVE-2025-22866       Medium       0.56  < 0.1  
gpgv                    2.4.4-2ubuntu17                                             deb        CVE-2022-3219        Low          1.20  < 0.1  
krb5-locales            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26458       Negligible  22.50  < 0.1  
libgssapi-krb5-2        1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26458       Negligible  22.50  < 0.1  
libk5crypto3            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26458       Negligible  22.50  < 0.1  
libkrb5-3               1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26458       Negligible  22.50  < 0.1  
libkrb5support0         1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2024-26458       Negligible  22.50  < 0.1  
libxml2                 2.9.14+dfsg-1.3ubuntu3       2.9.14+dfsg-1.3ubuntu3.2       deb        CVE-2025-24928       Medium       0.41  < 0.1  
libxml2                 2.9.14+dfsg-1.3ubuntu3       2.9.14+dfsg-1.3ubuntu3.2       deb        CVE-2024-56171       Medium       0.32  < 0.1  
libxslt1.1              1.1.39-0exp1build1           1.1.39-0exp1ubuntu0.24.04.1    deb        CVE-2024-55549       Medium       0.30  < 0.1  
jq                      1.7.1-3build1                                               deb        CVE-2024-53427       Low          0.70  < 0.1  
libjq1                  1.7.1-3build1                                               deb        CVE-2024-53427       Low          0.70  < 0.1  
clickhouse-client       18.16.1+ds-7.4build2                                        deb        CVE-2024-22412       Medium       0.21  < 0.1  
clickhouse-common       18.16.1+ds-7.4build2                                        deb        CVE-2024-22412       Medium       0.21  < 0.1  
krb5-locales            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2025-24528       Medium        N/A    N/A  
libgssapi-krb5-2        1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2025-24528       Medium        N/A    N/A  
libk5crypto3            1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2025-24528       Medium        N/A    N/A  
libkrb5-3               1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2025-24528       Medium        N/A    N/A  
libkrb5support0         1.20.1-6ubuntu2.1            1.20.1-6ubuntu2.5              deb        CVE-2025-24528       Medium        N/A    N/A  
libpng16-16t64          1.6.43-5build1                                              deb        CVE-2022-3857        Low           N/A    N/A  
libtiff6                4.5.1+git230720-4ubuntu2.2                                  deb        CVE-2024-6716        Low           N/A    N/A
```

## SBOM
```bash
NAME                                 VERSION                                  TYPE        
adduser                              3.137ubuntu1                             deb          
adwaita-icon-theme                   46.0-1                                   deb          
apt                                  2.7.14build2                             deb          
at-spi2-common                       2.52.0-1build1                           deb          
at-spi2-core                         2.52.0-1build1                           deb          
base-files                           13ubuntu10                               deb          
base-passwd                          3.6.3build1                              deb          
bash                                 5.2.21-2ubuntu4                          deb          
bind9-dnsutils                       1:9.18.28-0ubuntu0.24.04.1               deb          
bind9-host                           1:9.18.28-0ubuntu0.24.04.1               deb          
bind9-libs                           1:9.18.28-0ubuntu0.24.04.1               deb          
bsdutils                             1:2.39.3-9ubuntu6.1                      deb          
ca-certificates                      20240203                                 deb          
clickhouse-client                    18.16.1+ds-7.4build2                     deb          
clickhouse-common                    18.16.1+ds-7.4build2                     deb          
coreutils                            9.4-3ubuntu6                             deb          
curl                                 8.5.0-2ubuntu10.3                        deb          
dash                                 0.5.12-6ubuntu5                          deb          
dbus                                 1.14.10-4ubuntu4.1                       deb          
dbus-bin                             1.14.10-4ubuntu4.1                       deb          
dbus-daemon                          1.14.10-4ubuntu4.1                       deb          
dbus-python                          1.3.2                                    python       
dbus-session-bus-common              1.14.10-4ubuntu4.1                       deb          
dbus-system-bus-common               1.14.10-4ubuntu4.1                       deb          
dbus-user-session                    1.14.10-4ubuntu4.1                       deb          
dconf-gsettings-backend              0.40.0-4build2                           deb          
dconf-service                        0.40.0-4build2                           deb          
debconf                              1.5.86ubuntu1                            deb          
debianutils                          5.17build1                               deb          
diffutils                            1:3.10-1build1                           deb          
dmsetup                              2:1.02.185-3ubuntu3.1                    deb          
dnsutils                             1:9.18.28-0ubuntu0.24.04.1               deb          
dpkg                                 1.22.6ubuntu6                            deb          
duf                                  0.8.1-1ubuntu0.24.04.1                   deb          
e2fsprogs                            1.47.0-2.4~exp1ubuntu4                   deb          
findutils                            4.9.0-5build1                            deb          
fontconfig                           2.15.0-1.1ubuntu2                        deb          
fontconfig-config                    2.15.0-1.1ubuntu2                        deb          
fonts-dejavu-core                    2.37-8                                   deb          
fonts-dejavu-mono                    2.37-8                                   deb          
gcc-14-base                          14-20240412-0ubuntu1                     deb          
gir1.2-girepository-2.0              1.80.1-1                                 deb          
gir1.2-glib-2.0                      2.80.0-6ubuntu3.1                        deb          
github.com/a8m/envsubst              v1.4.2                                   go-module    
github.com/alecthomas/participle/v2  v2.1.1                                   go-module    
github.com/dimchansky/utfbom         v1.1.1                                   go-module    
github.com/elliotchance/orderedmap   v1.6.0                                   go-module    
github.com/fatih/color               v1.17.0                                  go-module    
github.com/goccy/go-json             v0.10.3                                  go-module    
github.com/goccy/go-yaml             v1.12.0                                  go-module    
github.com/jinzhu/copier             v0.4.0                                   go-module    
github.com/magiconair/properties     v1.8.7                                   go-module    
github.com/mattn/go-colorable        v0.1.13                                  go-module    
github.com/mattn/go-isatty           v0.0.20                                  go-module    
github.com/mikefarah/yq/v4           v0.0.0-20240805053857-bbdd97482f2d       go-module    
github.com/muesli/duf                UNKNOWN                                  go-module    
github.com/pelletier/go-toml/v2      v2.2.2                                   go-module    
github.com/spf13/cobra               v1.8.1                                   go-module    
github.com/spf13/pflag               v1.0.5                                   go-module    
github.com/yuin/gopher-lua           v1.1.1                                   go-module    
golang.org/x/net                     v0.27.0                                  go-module    
golang.org/x/sys                     v0.22.0                                  go-module    
golang.org/x/text                    v0.16.0                                  go-module    
golang.org/x/xerrors                 v0.0.0-20220907171357-04be3eba64a2       go-module    
gopkg.in/op/go-logging.v1            v1.0.0-20160211212156-b2cb9fa56473       go-module    
gopkg.in/yaml.v3                     v3.0.1                                   go-module    
gpgv                                 2.4.4-2ubuntu17                          deb          
grep                                 3.11-4build1                             deb          
gsettings-desktop-schemas            46.1-0ubuntu1                            deb          
gtk-update-icon-cache                3.24.41-4ubuntu1.1                       deb          
gzip                                 1.12-1ubuntu3                            deb          
hicolor-icon-theme                   0.17-2                                   deb          
hostname                             3.23+nmu2ubuntu2                         deb          
humanity-icon-theme                  0.6.16                                   deb          
hyperfine                            1.18.0-2build1                           deb          
ibverbs-providers                    50.0-2build2                             deb          
inetutils-telnet                     2:2.5-3ubuntu4                           deb          
init-system-helpers                  1.66ubuntu1                              deb          
iputils-ping                         3:20240117-1build1                       deb          
jq                                   1.7.1-3build1                            deb          
krb5-locales                         1.20.1-6ubuntu2.1                        deb          
less                                 590-2ubuntu2.1                           deb          
libacl1                              2.3.2-1build1                            deb          
libapparmor1                         4.0.1really4.0.0-beta3-0ubuntu0.1        deb          
libapt-pkg6.0t64                     2.7.14build2                             deb          
libargon2-1                          0~20190702+dfsg-4build1                  deb          
libassuan0                           2.5.6-1build1                            deb          
libatk-bridge2.0-0t64                2.52.0-1build1                           deb          
libatk1.0-0t64                       2.52.0-1build1                           deb          
libatspi2.0-0t64                     2.52.0-1build1                           deb          
libattr1                             1:2.5.2-1build1                          deb          
libaudit-common                      1:3.1.2-2.1build1                        deb          
libaudit1                            1:3.1.2-2.1build1                        deb          
libavahi-client3                     0.8-13ubuntu6                            deb          
libavahi-common-data                 0.8-13ubuntu6                            deb          
libavahi-common3                     0.8-13ubuntu6                            deb          
libblas3                             3.12.0-3build1.1                         deb          
libblkid1                            2.39.3-9ubuntu6.1                        deb          
libboost-filesystem1.83.0            1.83.0-2.1ubuntu3                        deb          
libboost-program-options1.83.0       1.83.0-2.1ubuntu3                        deb          
libbrotli1                           1.1.0-2build2                            deb          
libbsd0                              0.12.1-1build1                           deb          
libbz2-1.0                           1.0.8-5.1                                deb          
libc-bin                             2.39-0ubuntu8.3                          deb          
libc6                                2.39-0ubuntu8.3                          deb          
libcairo-gobject2                    1.18.0-3build1                           deb          
libcairo2                            1.18.0-3build1                           deb          
libcap-ng0                           0.8.4-2build2                            deb          
libcap2                              1:2.66-5ubuntu2                          deb          
libcap2-bin                          1:2.66-5ubuntu2                          deb          
libcapnp-1.0.1                       1.0.1-4                                  deb          
libcctz2                             2.3+dfsg1-5build1                        deb          
libcolord2                           1.4.7-1build2                            deb          
libcom-err2                          1.47.0-2.4~exp1ubuntu4                   deb          
libcommon-sense-perl                 3.75-3build3                             deb          
libcpuinfo0                          0.0~git20230113.6481e8b-2                deb          
libcrypt1                            1:4.4.36-4build1                         deb          
libcryptsetup12                      2:2.7.0-1ubuntu4.1                       deb          
libcups2t64                          2.4.7-1.2ubuntu7.2                       deb          
libcurl4t64                          8.5.0-2ubuntu10.3                        deb          
libdatrie1                           0.2.13-3build1                           deb          
libdb5.3t64                          5.3.28+dfsg2-7                           deb          
libdbus-1-3                          1.14.10-4ubuntu4.1                       deb          
libdconf1                            0.40.0-4build2                           deb          
libdebconfclient0                    0.271ubuntu3                             deb          
libdeflate0                          1.19-1build1.1                           deb          
libdevmapper1.02.1                   2:1.02.185-3ubuntu3.1                    deb          
libdouble-conversion3                3.3.0-1build1                            deb          
libedit2                             3.1-20230828-1build1                     deb          
libepoxy0                            1.5.10-1build1                           deb          
libexpat1                            2.6.1-2build1                            deb          
libext2fs2t64                        1.47.0-2.4~exp1ubuntu4                   deb          
libfarmhash0                         0~git20190513.0d859a8-2build1            deb          
libfdisk1                            2.39.3-9ubuntu6.1                        deb          
libffi8                              3.4.6-1build1                            deb          
libfontconfig1                       2.15.0-1.1ubuntu2                        deb          
libfreetype6                         2.13.2+dfsg-1build3                      deb          
libfribidi0                          1.0.13-3build1                           deb          
libgcc-s1                            14-20240412-0ubuntu1                     deb          
libgcrypt20                          1.10.3-2build1                           deb          
libgdbm-compat4t64                   1.23-5.1build1                           deb          
libgdbm6t64                          1.23-5.1build1                           deb          
libgdk-pixbuf-2.0-0                  2.42.10+dfsg-3ubuntu3.1                  deb          
libgdk-pixbuf2.0-bin                 2.42.10+dfsg-3ubuntu3.1                  deb          
libgdk-pixbuf2.0-common              2.42.10+dfsg-3ubuntu3.1                  deb          
libgirepository-1.0-1                1.80.1-1                                 deb          
libglib2.0-0t64                      2.80.0-6ubuntu3.1                        deb          
libglib2.0-data                      2.80.0-6ubuntu3.1                        deb          
libgmp10                             2:6.3.0+dfsg-2ubuntu6                    deb          
libgnutls30t64                       3.8.3-1.1ubuntu3.1                       deb          
libgpg-error0                        1.47-3build2                             deb          
libgpm2                              1.20.7-11                                deb          
libgraphite2-3                       1.3.14-2build1                           deb          
libgssapi-krb5-2                     1.20.1-6ubuntu2.1                        deb          
libgtk-3-0t64                        3.24.41-4ubuntu1.1                       deb          
libgtk-3-bin                         3.24.41-4ubuntu1.1                       deb          
libgtk-3-common                      3.24.41-4ubuntu1.1                       deb          
libharfbuzz0b                        8.3.0-2build2                            deb          
libhogweed6t64                       3.9.1-2.2build1                          deb          
libibverbs1                          50.0-2build2                             deb          
libicu74                             74.2-1ubuntu3.1                          deb          
libidn2-0                            2.3.7-2build1                            deb          
libjansson4                          2.14-2build2                             deb          
libjbig0                             2.1-6.1ubuntu2                           deb          
libjemalloc2                         5.3.0-2build1                            deb          
libjpeg-turbo8                       2.1.5-2ubuntu2                           deb          
libjpeg8                             8c-2ubuntu11                             deb          
libjq1                               1.7.1-3build1                            deb          
libjson-c5                           0.17-1build1                             deb          
libjson-perl                         4.10000-1                                deb          
libjson-xs-perl                      4.030-2build3                            deb          
libk5crypto3                         1.20.1-6ubuntu2.1                        deb          
libkeyutils1                         1.6.3-3build1                            deb          
libkmod2                             31+20240202-2ubuntu7                     deb          
libkrb5-3                            1.20.1-6ubuntu2.1                        deb          
libkrb5support0                      1.20.1-6ubuntu2.1                        deb          
liblcms2-2                           2.14-2build1                             deb          
libldap-common                       2.6.7+dfsg-1~exp1ubuntu8                 deb          
libldap2                             2.6.7+dfsg-1~exp1ubuntu8                 deb          
liblerc4                             4.0.0+ds-4ubuntu2                        deb          
liblinear4                           2.3.0+dfsg-5build1                       deb          
libllvm17t64                         1:17.0.6-9ubuntu1                        deb          
liblmdb0                             0.9.31-1build1                           deb          
libltdl7                             2.4.7-7build1                            deb          
liblua5.4-0                          5.4.6-3build2                            deb          
liblz4-1                             1.9.4-1build1                            deb          
liblzma5                             5.6.1+really5.4.5-1build0.1              deb          
libmaxminddb0                        1.9.1-1build1                            deb          
libmd0                               1.1.0-2build1                            deb          
libmetrohash1                        1.1.3-4build2                            deb          
libmount1                            2.39.3-9ubuntu6.1                        deb          
libmysqlclient21                     8.0.39-0ubuntu0.24.04.2                  deb          
libncurses6                          6.4+20240113-1ubuntu2                    deb          
libncursesw6                         6.4+20240113-1ubuntu2                    deb          
libnettle8t64                        3.9.1-2.2build1                          deb          
libnghttp2-14                        1.59.0-1ubuntu0.1                        deb          
libnl-3-200                          3.7.0-0.3build1                          deb          
libnl-route-3-200                    3.7.0-0.3build1                          deb          
libnpth0t64                          1.6-3.1build1                            deb          
libnss-systemd                       255.4-1ubuntu8.4                         deb          
libodbc2                             2.3.12-1ubuntu0.24.04.1                  deb          
libonig5                             6.9.9-1build1                            deb          
libp11-kit0                          0.25.3-4ubuntu2                          deb          
libpam-cap                           1:2.66-5ubuntu2                          deb          
libpam-modules                       1.5.3-5ubuntu5.1                         deb          
libpam-modules-bin                   1.5.3-5ubuntu5.1                         deb          
libpam-runtime                       1.5.3-5ubuntu5.1                         deb          
libpam-systemd                       255.4-1ubuntu8.4                         deb          
libpam0g                             1.5.3-5ubuntu5.1                         deb          
libpango-1.0-0                       1.52.1+ds-1build1                        deb          
libpangocairo-1.0-0                  1.52.1+ds-1build1                        deb          
libpangoft2-1.0-0                    1.52.1+ds-1build1                        deb          
libpcap0.8t64                        1.10.4-4.1ubuntu3                        deb          
libpcre2-8-0                         10.42-4ubuntu2                           deb          
libpcre3                             2:8.39-15build1                          deb          
libperl5.38t64                       5.38.2-3.2build2                         deb          
libpixman-1-0                        0.42.2-1build1                           deb          
libpng16-16t64                       1.6.43-5build1                           deb          
libpococrypto80t64                   1.11.0-4.1build2                         deb          
libpocodata80t64                     1.11.0-4.1build2                         deb          
libpocodataodbc80t64                 1.11.0-4.1build2                         deb          
libpocofoundation80t64               1.11.0-4.1build2                         deb          
libpocojson80t64                     1.11.0-4.1build2                         deb          
libpocomongodb80t64                  1.11.0-4.1build2                         deb          
libpoconet80t64                      1.11.0-4.1build2                         deb          
libpoconetssl80t64                   1.11.0-4.1build2                         deb          
libpocoutil80t64                     1.11.0-4.1build2                         deb          
libpocoxml80t64                      1.11.0-4.1build2                         deb          
libpopt0                             1.19+dfsg-1build1                        deb          
libpq5                               16.4-0ubuntu0.24.04.2                    deb          
libproc2-0                           2:4.0.4-4ubuntu3                         deb          
libpsl5t64                           0.21.2-1.1build1                         deb          
libpython3-stdlib                    3.12.3-0ubuntu2                          deb          
libpython3.12-minimal                3.12.3-1ubuntu0.1                        deb          
libpython3.12-stdlib                 3.12.3-1ubuntu0.1                        deb          
librdkafka1                          2.3.0-1build2                            deb          
libre2-10                            20230301-3build1                         deb          
libreadline8t64                      8.2-4build1                              deb          
librsvg2-2                           2.58.0+dfsg-1build1                      deb          
librsvg2-common                      2.58.0+dfsg-1build1                      deb          
librtmp1                             2.4+20151223.gitfa8646d.1-2build7        deb          
libsasl2-2                           2.1.28+dfsg1-5ubuntu3.1                  deb          
libsasl2-modules                     2.1.28+dfsg1-5ubuntu3.1                  deb          
libsasl2-modules-db                  2.1.28+dfsg1-5ubuntu3.1                  deb          
libseccomp2                          2.5.5-1ubuntu3                           deb          
libselinux1                          3.5-2ubuntu2                             deb          
libsemanage-common                   3.5-1build5                              deb          
libsemanage2                         3.5-1build5                              deb          
libsensors-config                    1:3.6.0-9build1                          deb          
libsensors5                          1:3.6.0-9build1                          deb          
libsepol2                            3.5-2build1                              deb          
libsharpyuv0                         1.3.2-0.4build3                          deb          
libsmartcols1                        2.39.3-9ubuntu6.1                        deb          
libsqlite3-0                         3.45.1-1ubuntu2                          deb          
libss2                               1.47.0-2.4~exp1ubuntu4                   deb          
libssh-4                             0.10.6-2build2                           deb          
libssh2-1t64                         1.11.0-4.1build2                         deb          
libssl3t64                           3.0.13-0ubuntu3.4                        deb          
libstdc++6                           14-20240412-0ubuntu1                     deb          
libsystemd-shared                    255.4-1ubuntu8.4                         deb          
libsystemd0                          255.4-1ubuntu8.4                         deb          
libtasn1-6                           4.19.0-3build1                           deb          
libthai-data                         0.1.29-2build1                           deb          
libthai0                             0.1.29-2build1                           deb          
libtiff6                             4.5.1+git230720-4ubuntu2.2               deb          
libtinfo6                            6.4+20240113-1ubuntu2                    deb          
libtypes-serialiser-perl             1.01-1                                   deb          
libudev1                             255.4-1ubuntu8.4                         deb          
libunistring5                        1.1-2build1                              deb          
libuuid1                             2.39.3-9ubuntu6.1                        deb          
libuv1t64                            1.48.0-1.1build1                         deb          
libwayland-client0                   1.22.0-2.1build1                         deb          
libwayland-cursor0                   1.22.0-2.1build1                         deb          
libwayland-egl1                      1.22.0-2.1build1                         deb          
libwebp7                             1.3.2-0.4build3                          deb          
libx11-6                             2:1.8.7-1build1                          deb          
libx11-data                          2:1.8.7-1build1                          deb          
libxau6                              1:1.0.9-1build6                          deb          
libxcb-render0                       1.15-1ubuntu2                            deb          
libxcb-shm0                          1.15-1ubuntu2                            deb          
libxcb1                              1.15-1ubuntu2                            deb          
libxcomposite1                       1:0.4.5-1build3                          deb          
libxcursor1                          1:1.2.1-1build1                          deb          
libxdamage1                          1:1.1.6-1build1                          deb          
libxdmcp6                            1:1.1.3-0ubuntu6                         deb          
libxext6                             2:1.3.4-1build2                          deb          
libxfixes3                           1:6.0.0-2build1                          deb          
libxi6                               2:1.8.1-1build1                          deb          
libxinerama1                         2:1.1.4-3build1                          deb          
libxkbcommon0                        1.6.0-1build1                            deb          
libxml2                              2.9.14+dfsg-1.3ubuntu3                   deb          
libxrandr2                           2:1.5.2-2build1                          deb          
libxrender1                          1:0.9.10-1.1build1                       deb          
libxslt1.1                           1.1.39-0exp1build1                       deb          
libxtst6                             2:1.2.3-1.1build1                        deb          
libxxhash0                           0.8.2-2build1                            deb          
libzstd1                             1.5.5+dfsg2-2build1                      deb          
locales                              2.39-0ubuntu8.3                          deb          
login                                1:4.13+dfsg1-4ubuntu3                    deb          
logrotate                            3.21.0-2build1                           deb          
logsave                              1.47.0-2.4~exp1ubuntu4                   deb          
mawk                                 1.3.4.20240123-1build1                   deb          
media-types                          10.1.0                                   deb          
mount                                2.39.3-9ubuntu6.1                        deb          
mtr                                  0.95-1.1build2                           deb          
mysql-common                         5.8+1.1.0build1                          deb          
ncurses-base                         6.4+20240113-1ubuntu2                    deb          
ncurses-bin                          6.4+20240113-1ubuntu2                    deb          
netbase                              6.4                                      deb          
netcat-traditional                   1.10-48                                  deb          
networkd-dispatcher                  2.2.4-1                                  deb          
nmap                                 7.94+git20230807.3be01efb1+dfsg-3build2  deb          
nmap-common                          7.94+git20230807.3be01efb1+dfsg-3build2  deb          
openssl                              3.0.13-0ubuntu3.4                        deb          
passwd                               1:4.13+dfsg1-4ubuntu3                    deb          
perl                                 5.38.2-3.2build2                         deb          
perl-base                            5.38.2-3.2build2                         deb          
perl-modules-5.38                    5.38.2-3.2build2                         deb          
postgresql                           16+257build1.1                           deb          
postgresql-16                        16.4-0ubuntu0.24.04.2                    deb          
postgresql-client-16                 16.4-0ubuntu0.24.04.2                    deb          
postgresql-client-common             257build1.1                              deb          
postgresql-common                    257build1.1                              deb          
procps                               2:4.0.4-4ubuntu3                         deb          
publicsuffix                         20231001.0357-0.1                        deb          
pygobject                            3.48.2                                   python       
python3                              3.12.3-0ubuntu2                          deb          
python3-dbus                         1.3.2-5build3                            deb          
python3-gi                           3.48.2-1                                 deb          
python3-minimal                      3.12.3-0ubuntu2                          deb          
python3.12                           3.12.3-1ubuntu0.1                        deb          
python3.12-minimal                   3.12.3-1ubuntu0.1                        deb          
readline-common                      8.2-4build1                              deb          
rsync                                3.2.7-1ubuntu1                           deb          
sed                                  4.9-2build1                              deb          
sensible-utils                       0.0.22                                   deb          
session-migration                    0.3.9build1                              deb          
shared-mime-info                     2.4-4                                    deb          
ssl-cert                             1.1.2ubuntu1                             deb          
stdlib                               go1.22.2                                 go-module    
stdlib                               go1.22.5                                 go-module    
sysstat                              12.6.1-2                                 deb          
systemd                              255.4-1ubuntu8.4                         deb          
systemd-dev                          255.4-1ubuntu8.4                         deb          
systemd-resolved                     255.4-1ubuntu8.4                         deb          
systemd-sysv                         255.4-1ubuntu8.4                         deb          
systemd-timesyncd                    255.4-1ubuntu8.4                         deb          
sysvinit-utils                       3.08-6ubuntu3                            deb          
tar                                  1.35+dfsg-3build1                        deb          
tcpdump                              4.99.4-3ubuntu4                          deb          
telnet                               0.17+2.5-3ubuntu4                        deb          
traceroute                           1:2.1.5-1                                deb          
tzdata                               2024a-3ubuntu1.1                         deb          
ubuntu-keyring                       2023.11.28.1                             deb          
ubuntu-mono                          24.04-0ubuntu1                           deb          
ucf                                  3.0043+nmu1                              deb          
unzip                                6.0-28ubuntu4                            deb          
util-linux                           2.39.3-9ubuntu6.1                        deb          
wget                                 1.21.4-1ubuntu4.1                        deb          
x11-common                           1:7.7+23ubuntu3                          deb          
xdg-user-dirs                        0.18-1build1                             deb          
xkb-data                             2.41-2ubuntu1.1                          deb          
xz-utils                             5.6.1+really5.4.5-1build0.1              deb          
zlib1g                               1:1.3.dfsg-3.1ubuntu2                    deb
```

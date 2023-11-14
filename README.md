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

> Uses Default namespace so change if required

```bash
# start pod, execute command, exit and remove pod
k run -i --tty --rm k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never -- \
curl -L --head google.co.uk

# start pod, open shell
k run -i --tty --rm k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never

# execute command on running pod
k exec k8s-toolkit -- ps aux

# open shell on running pod
k exec --stdin --tty k8s-toolkit -- /bin/bash

# stop and remove pod
k delete po k8s-toolkit
```

### Docker
```bash
# run single command
d run -it --rm \
--name kubernetes-admin-toolkit-throwaway \
adegoodyer/kubernetes-admin-toolkit:latest \
curl -L --head google.co.uk

# disposable container
d run -it --rm \
--name kubernetes-admin-toolkit-throwaway \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container
d run -itd \
--name kubernetes-admin-toolkit-latest \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container (specify network)
d run -itd \
--network host \
--name kubernetes-admin-toolkit-latest \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container (network of another container)
# (must change CONTAINER_NAME)
d run -itd \
--network container:CONTAINER_NAME \
--name kubernetes-admin-toolkit-latest \
adegoodyer/kubernetes-admin-toolkit:latest

# connect to persistent container
d exec -it kubernetes-admin-toolkit-latest /bin/bash

# stop and remove persistent container
# (d kill won't always remove)
d stop kubernetes-admin-toolkit-latest && \
d rm kubernetes-admin-toolkit-latest
```

## Security Scan
```bash
NAME                  INSTALLED                     FIXED-IN           TYPE       VULNERABILITY        SEVERITY   
bash                  5.1-6ubuntu1                                     deb        CVE-2022-3715        Low         
coreutils             8.32-4.1ubuntu1                                  deb        CVE-2016-2781        Low         
dbus                  1.12.20-2ubuntu4.1                               deb        CVE-2023-34969       Low         
gcc-12-base           12.3.0-1ubuntu1~22.04                            deb        CVE-2022-27943       Low         
golang.org/x/net      v0.15.0                       0.17.0             go-module  GHSA-4374-p667-p6c8  High        
golang.org/x/net      v0.15.0                       0.17.0             go-module  GHSA-qppj-fm5r-hxr3  Medium      
gpgv                  2.2.27-3ubuntu2.1                                deb        CVE-2022-3219        Low         
libapparmor1          3.0.4-2ubuntu2.2                                 deb        CVE-2016-1585        Medium      
libavahi-client3      0.8-5ubuntu5.1                                   deb        CVE-2023-38469       Medium      
libavahi-client3      0.8-5ubuntu5.1                                   deb        CVE-2023-38470       Medium      
libavahi-client3      0.8-5ubuntu5.1                                   deb        CVE-2023-38471       Medium      
libavahi-client3      0.8-5ubuntu5.1                                   deb        CVE-2023-38472       Medium      
libavahi-client3      0.8-5ubuntu5.1                                   deb        CVE-2023-38473       Medium      
libavahi-common-data  0.8-5ubuntu5.1                                   deb        CVE-2023-38469       Medium      
libavahi-common-data  0.8-5ubuntu5.1                                   deb        CVE-2023-38470       Medium      
libavahi-common-data  0.8-5ubuntu5.1                                   deb        CVE-2023-38471       Medium      
libavahi-common-data  0.8-5ubuntu5.1                                   deb        CVE-2023-38472       Medium      
libavahi-common-data  0.8-5ubuntu5.1                                   deb        CVE-2023-38473       Medium      
libavahi-common3      0.8-5ubuntu5.1                                   deb        CVE-2023-38469       Medium      
libavahi-common3      0.8-5ubuntu5.1                                   deb        CVE-2023-38470       Medium      
libavahi-common3      0.8-5ubuntu5.1                                   deb        CVE-2023-38471       Medium      
libavahi-common3      0.8-5ubuntu5.1                                   deb        CVE-2023-38472       Medium      
libavahi-common3      0.8-5ubuntu5.1                                   deb        CVE-2023-38473       Medium      
libc-bin              2.35-0ubuntu3.4                                  deb        CVE-2016-20013       Negligible  
libc-bin              2.35-0ubuntu3.4                                  deb        CVE-2023-4806        Low         
libc-bin              2.35-0ubuntu3.4                                  deb        CVE-2023-4813        Low         
libc-bin              2.35-0ubuntu3.4                                  deb        CVE-2023-5156        Medium      
libc6                 2.35-0ubuntu3.4                                  deb        CVE-2016-20013       Negligible  
libc6                 2.35-0ubuntu3.4                                  deb        CVE-2023-4806        Low         
libc6                 2.35-0ubuntu3.4                                  deb        CVE-2023-4813        Low         
libc6                 2.35-0ubuntu3.4                                  deb        CVE-2023-5156        Medium      
libcairo-gobject2     1.16.0-5ubuntu2                                  deb        CVE-2017-7475        Low         
libcairo-gobject2     1.16.0-5ubuntu2                                  deb        CVE-2018-18064       Low         
libcairo-gobject2     1.16.0-5ubuntu2                                  deb        CVE-2019-6461        Low         
libcairo2             1.16.0-5ubuntu2                                  deb        CVE-2017-7475        Low         
libcairo2             1.16.0-5ubuntu2                                  deb        CVE-2018-18064       Low         
libcairo2             1.16.0-5ubuntu2                                  deb        CVE-2019-6461        Low         
libdbus-1-3           1.12.20-2ubuntu4.1                               deb        CVE-2023-34969       Low         
libgcc-s1             12.3.0-1ubuntu1~22.04                            deb        CVE-2022-27943       Low         
libgssapi-krb5-2      1.19.2-2ubuntu0.2             1.19.2-2ubuntu0.3  deb        CVE-2023-36054       Medium      
libharfbuzz0b         2.7.4-1ubuntu3.1                                 deb        CVE-2023-25193       Low         
libk5crypto3          1.19.2-2ubuntu0.2             1.19.2-2ubuntu0.3  deb        CVE-2023-36054       Medium      
libkrb5-3             1.19.2-2ubuntu0.2             1.19.2-2ubuntu0.3  deb        CVE-2023-36054       Medium      
libkrb5support0       1.19.2-2ubuntu0.2             1.19.2-2ubuntu0.3  deb        CVE-2023-36054       Medium      
libldap-2.5-0         2.5.16+dfsg-0ubuntu0.22.04.1                     deb        CVE-2023-2953        Low         
libldap-common        2.5.16+dfsg-0ubuntu0.22.04.1                     deb        CVE-2023-2953        Low         
liblzma5              5.2.5-2ubuntu1                                   deb        CVE-2020-22916       Medium      
libpcre3              2:8.39-13ubuntu0.22.04.1                         deb        CVE-2017-11164       Negligible  
libperl5.34           5.34.0-3ubuntu1.2                                deb        CVE-2022-48522       Low         
libpixman-1-0         0.40.0-1ubuntu0.22.04.1                          deb        CVE-2023-37769       Medium      
libpng16-16           1.6.37-3build5                                   deb        CVE-2022-3857        Low         
libprocps8            2:3.3.17-6ubuntu2                                deb        CVE-2023-4016        Low         
libssl3               3.0.2-0ubuntu1.10             3.0.2-0ubuntu1.12  deb        CVE-2023-2975        Low         
libssl3               3.0.2-0ubuntu1.10             3.0.2-0ubuntu1.12  deb        CVE-2023-3446        Low         
libssl3               3.0.2-0ubuntu1.10             3.0.2-0ubuntu1.12  deb        CVE-2023-3817        Low         
libssl3               3.0.2-0ubuntu1.10             3.0.2-0ubuntu1.12  deb        CVE-2023-5363        Medium      
libstdc++6            12.3.0-1ubuntu1~22.04                            deb        CVE-2022-27943       Low         
libtiff5              4.3.0-6ubuntu0.6                                 deb        CVE-2018-10126       Low         
libtiff5              4.3.0-6ubuntu0.6                                 deb        CVE-2023-3164        Low         
libtiff5              4.3.0-6ubuntu0.6                                 deb        CVE-2023-3576        Negligible  
libzstd1              1.4.8+dfsg-3build1                               deb        CVE-2022-4899        Low         
locales               2.35-0ubuntu3.4                                  deb        CVE-2016-20013       Negligible  
locales               2.35-0ubuntu3.4                                  deb        CVE-2023-4806        Low         
locales               2.35-0ubuntu3.4                                  deb        CVE-2023-4813        Low         
locales               2.35-0ubuntu3.4                                  deb        CVE-2023-5156        Medium      
login                 1:4.8.1-2ubuntu2.1                               deb        CVE-2023-29383       Low         
passwd                1:4.8.1-2ubuntu2.1                               deb        CVE-2023-29383       Low         
perl                  5.34.0-3ubuntu1.2                                deb        CVE-2022-48522       Low         
perl-base             5.34.0-3ubuntu1.2                                deb        CVE-2022-48522       Low         
perl-modules-5.34     5.34.0-3ubuntu1.2                                deb        CVE-2022-48522       Low         
procps                2:3.3.17-6ubuntu2                                deb        CVE-2023-4016        Low         
wget                  1.21.2-2ubuntu1                                  deb        CVE-2021-31879       Medium      
xz-utils              5.2.5-2ubuntu1                                   deb        CVE-2020-22916       Medium      
```

## SBOM
```bash
NAME                                 VERSION                                  TYPE      
adduser                              3.118ubuntu5                             deb        
adwaita-icon-theme                   41.0-1ubuntu1                            deb        
apt                                  2.4.10                                   deb        
base-files                           12ubuntu4.4                              deb        
base-passwd                          3.5.52build1                             deb        
bash                                 5.1-6ubuntu1                             deb        
bind9-dnsutils                       1:9.18.18-0ubuntu0.22.04.1               deb        
bind9-host                           1:9.18.18-0ubuntu0.22.04.1               deb        
bind9-libs                           1:9.18.18-0ubuntu0.22.04.1               deb        
bsdutils                             1:2.37.2-4ubuntu3                        deb        
ca-certificates                      20230311ubuntu0.22.04.1                  deb        
coreutils                            8.32-4.1ubuntu1                          deb        
cron                                 3.0pl1-137ubuntu3                        deb        
curl                                 7.81.0-1ubuntu1.14                       deb        
dash                                 0.5.11+git20210903+057cd650a4ed-3build1  deb        
dbus                                 1.12.20-2ubuntu4.1                       deb        
debconf                              1.5.79ubuntu1                            deb        
debianutils                          5.5-1ubuntu2                             deb        
diffutils                            1:3.8-0ubuntu2                           deb        
dnsutils                             1:9.18.18-0ubuntu0.22.04.1               deb        
dpkg                                 1.21.1ubuntu2.2                          deb        
duf                                  0.6.2-1build1                            deb        
e2fsprogs                            1.46.5-2ubuntu1.1                        deb        
findutils                            4.8.0-1ubuntu3                           deb        
fontconfig                           2.13.1-4.2ubuntu5                        deb        
fontconfig-config                    2.13.1-4.2ubuntu5                        deb        
fonts-dejavu-core                    2.37-2build1                             deb        
gcc-12-base                          12.3.0-1ubuntu1~22.04                    deb        
github.com/a8m/envsubst              v1.4.2                                   go-module  
github.com/alecthomas/participle/v2  v2.1.0                                   go-module  
github.com/dimchansky/utfbom         v1.1.1                                   go-module  
github.com/elliotchance/orderedmap   v1.5.0                                   go-module  
github.com/fatih/color               v1.15.0                                  go-module  
github.com/goccy/go-json             v0.10.2                                  go-module  
github.com/goccy/go-yaml             v1.11.2                                  go-module  
github.com/jinzhu/copier             v0.4.0                                   go-module  
github.com/magiconair/properties     v1.8.7                                   go-module  
github.com/mattn/go-colorable        v0.1.13                                  go-module  
github.com/mattn/go-isatty           v0.0.17                                  go-module  
github.com/mikefarah/yq/v4           v0.0.0-20230926044852-a198f72367ce       go-module  
github.com/pelletier/go-toml/v2      v2.1.0                                   go-module  
github.com/spf13/cobra               v1.7.0                                   go-module  
github.com/spf13/pflag               v1.0.5                                   go-module  
golang.org/x/net                     v0.15.0                                  go-module  
golang.org/x/sys                     v0.12.0                                  go-module  
golang.org/x/text                    v0.13.0                                  go-module  
golang.org/x/xerrors                 v0.0.0-20220609144429-65e65417b02f       go-module  
gopkg.in/op/go-logging.v1            v1.0.0-20160211212156-b2cb9fa56473       go-module  
gopkg.in/yaml.v3                     v3.0.1                                   go-module  
gpgv                                 2.2.27-3ubuntu2.1                        deb        
grep                                 3.7-1build1                              deb        
gtk-update-icon-cache                3.24.33-1ubuntu2                         deb        
gzip                                 1.10-4ubuntu4.1                          deb        
hicolor-icon-theme                   0.17-2                                   deb        
hostname                             3.23ubuntu2                              deb        
humanity-icon-theme                  0.6.16                                   deb        
hyperfine                            1.12.0-3ubuntu0.1                        deb        
init-system-helpers                  1.62                                     deb        
jq                                   1.6-2.1ubuntu3                           deb        
libacl1                              2.3.1-1                                  deb        
libapparmor1                         3.0.4-2ubuntu2.2                         deb        
libapt-pkg6.0                        2.4.10                                   deb        
libatk1.0-0                          2.36.0-3build1                           deb        
libatk1.0-data                       2.36.0-3build1                           deb        
libattr1                             1:2.5.1-1build1                          deb        
libaudit-common                      1:3.0.7-1build1                          deb        
libaudit1                            1:3.0.7-1build1                          deb        
libavahi-client3                     0.8-5ubuntu5.1                           deb        
libavahi-common-data                 0.8-5ubuntu5.1                           deb        
libavahi-common3                     0.8-5ubuntu5.1                           deb        
libblas3                             3.10.0-2ubuntu1                          deb        
libblkid1                            2.37.2-4ubuntu3                          deb        
libbrotli1                           1.0.9-2build6                            deb        
libbsd0                              0.11.5-1                                 deb        
libbz2-1.0                           1.0.8-5build1                            deb        
libc-bin                             2.35-0ubuntu3.4                          deb        
libc6                                2.35-0ubuntu3.4                          deb        
libcairo-gobject2                    1.16.0-5ubuntu2                          deb        
libcairo2                            1.16.0-5ubuntu2                          deb        
libcap-ng0                           0.7.9-2.2build3                          deb        
libcap2                              1:2.44-1ubuntu0.22.04.1                  deb        
libcom-err2                          1.46.5-2ubuntu1.1                        deb        
libcommon-sense-perl                 3.75-2build1                             deb        
libcrypt1                            1:4.4.27-1                               deb        
libcups2                             2.4.1op1-1ubuntu4.7                      deb        
libcurl4                             7.81.0-1ubuntu1.14                       deb        
libdatrie1                           0.2.13-2                                 deb        
libdb5.3                             5.3.28+dfsg1-0.8ubuntu3                  deb        
libdbus-1-3                          1.12.20-2ubuntu4.1                       deb        
libdebconfclient0                    0.261ubuntu1                             deb        
libdeflate0                          1.10-2                                   deb        
libedit2                             3.1-20210910-1build1                     deb        
libexpat1                            2.4.7-1ubuntu0.2                         deb        
libext2fs2                           1.46.5-2ubuntu1.1                        deb        
libffi8                              3.4.2-4                                  deb        
libfontconfig1                       2.13.1-4.2ubuntu5                        deb        
libfreetype6                         2.11.1+dfsg-1ubuntu0.2                   deb        
libfribidi0                          1.0.8-2ubuntu3.1                         deb        
libgail-common                       2.24.33-2ubuntu2                         deb        
libgail18                            2.24.33-2ubuntu2                         deb        
libgcc-s1                            12.3.0-1ubuntu1~22.04                    deb        
libgcrypt20                          1.9.4-3ubuntu3                           deb        
libgdbm-compat4                      1.23-1                                   deb        
libgdbm6                             1.23-1                                   deb        
libgdk-pixbuf-2.0-0                  2.42.8+dfsg-1ubuntu0.2                   deb        
libgdk-pixbuf2.0-bin                 2.42.8+dfsg-1ubuntu0.2                   deb        
libgdk-pixbuf2.0-common              2.42.8+dfsg-1ubuntu0.2                   deb        
libglib2.0-0                         2.72.4-0ubuntu2.2                        deb        
libglib2.0-data                      2.72.4-0ubuntu2.2                        deb        
libgmp10                             2:6.2.1+dfsg-3ubuntu1                    deb        
libgnutls30                          3.7.3-4ubuntu1.2                         deb        
libgpg-error0                        1.43-3                                   deb        
libgraphite2-3                       1.3.14-1build2                           deb        
libgssapi-krb5-2                     1.19.2-2ubuntu0.2                        deb        
libgtk2.0-0                          2.24.33-2ubuntu2                         deb        
libgtk2.0-bin                        2.24.33-2ubuntu2                         deb        
libgtk2.0-common                     2.24.33-2ubuntu2                         deb        
libharfbuzz0b                        2.7.4-1ubuntu3.1                         deb        
libhogweed6                          3.7.3-1build2                            deb        
libicu70                             70.1-2                                   deb        
libidn2-0                            2.3.2-2build1                            deb        
libjansson4                          2.13.1-1.1build3                         deb        
libjbig0                             2.1-3.1ubuntu0.22.04.1                   deb        
libjpeg-turbo8                       2.1.2-0ubuntu1                           deb        
libjpeg8                             8c-2ubuntu10                             deb        
libjq1                               1.6-2.1ubuntu3                           deb        
libjson-c5                           0.15-3~ubuntu1.22.04.2                   deb        
libjson-perl                         4.04000-1                                deb        
libjson-xs-perl                      4.030-1build3                            deb        
libk5crypto3                         1.19.2-2ubuntu0.2                        deb        
libkeyutils1                         1.6.1-2ubuntu3                           deb        
libkrb5-3                            1.19.2-2ubuntu0.2                        deb        
libkrb5support0                      1.19.2-2ubuntu0.2                        deb        
libldap-2.5-0                        2.5.16+dfsg-0ubuntu0.22.04.1             deb        
libldap-common                       2.5.16+dfsg-0ubuntu0.22.04.1             deb        
liblinear4                           2.3.0+dfsg-5                             deb        
libllvm14                            1:14.0.0-1ubuntu1.1                      deb        
liblmdb0                             0.9.24-1build2                           deb        
liblua5.3-0                          5.3.6-1build1                            deb        
liblz4-1                             1.9.3-2build2                            deb        
liblzma5                             5.2.5-2ubuntu1                           deb        
libmaxminddb0                        1.5.2-1build2                            deb        
libmd0                               1.0.4-1build1                            deb        
libmount1                            2.37.2-4ubuntu3                          deb        
libncurses6                          6.3-2ubuntu0.1                           deb        
libncursesw6                         6.3-2ubuntu0.1                           deb        
libnettle8                           3.7.3-1build2                            deb        
libnghttp2-14                        1.43.0-1build3                           deb        
libnsl2                              1.3.0-2build2                            deb        
libonig5                             6.9.7.1-2build1                          deb        
libp11-kit0                          0.24.0-6build1                           deb        
libpam-modules                       1.4.0-11ubuntu2.3                        deb        
libpam-modules-bin                   1.4.0-11ubuntu2.3                        deb        
libpam-runtime                       1.4.0-11ubuntu2.3                        deb        
libpam0g                             1.4.0-11ubuntu2.3                        deb        
libpango-1.0-0                       1.50.6+ds-2ubuntu1                       deb        
libpangocairo-1.0-0                  1.50.6+ds-2ubuntu1                       deb        
libpangoft2-1.0-0                    1.50.6+ds-2ubuntu1                       deb        
libpcap0.8                           1.10.1-4build1                           deb        
libpcre2-8-0                         10.39-3ubuntu0.1                         deb        
libpcre3                             2:8.39-13ubuntu0.22.04.1                 deb        
libperl5.34                          5.34.0-3ubuntu1.2                        deb        
libpixman-1-0                        0.40.0-1ubuntu0.22.04.1                  deb        
libpng16-16                          1.6.37-3build5                           deb        
libpopt0                             1.18-3build1                             deb        
libpq5                               14.9-0ubuntu0.22.04.1                    deb        
libprocps8                           2:3.3.17-6ubuntu2                        deb        
libpsl5                              0.21.0-1.2build2                         deb        
libreadline8                         8.1.2-1                                  deb        
librsvg2-2                           2.52.5+dfsg-3ubuntu0.2                   deb        
librsvg2-common                      2.52.5+dfsg-3ubuntu0.2                   deb        
librtmp1                             2.4+20151223.gitfa8646d.1-2build4        deb        
libsasl2-2                           2.1.27+dfsg2-3ubuntu1.2                  deb        
libsasl2-modules                     2.1.27+dfsg2-3ubuntu1.2                  deb        
libsasl2-modules-db                  2.1.27+dfsg2-3ubuntu1.2                  deb        
libseccomp2                          2.5.3-2ubuntu2                           deb        
libselinux1                          3.3-1build2                              deb        
libsemanage-common                   3.3-1build2                              deb        
libsemanage2                         3.3-1build2                              deb        
libsensors-config                    1:3.6.0-7ubuntu1                         deb        
libsensors5                          1:3.6.0-7ubuntu1                         deb        
libsepol2                            3.3-1build1                              deb        
libsmartcols1                        2.37.2-4ubuntu3                          deb        
libss2                               1.46.5-2ubuntu1.1                        deb        
libssh-4                             0.9.6-2ubuntu0.22.04.1                   deb        
libssl3                              3.0.2-0ubuntu1.10                        deb        
libstdc++6                           12.3.0-1ubuntu1~22.04                    deb        
libsystemd0                          249.11-0ubuntu3.10                       deb        
libtasn1-6                           4.18.0-4build1                           deb        
libthai-data                         0.1.29-1build1                           deb        
libthai0                             0.1.29-1build1                           deb        
libtiff5                             4.3.0-6ubuntu0.6                         deb        
libtinfo6                            6.3-2ubuntu0.1                           deb        
libtirpc-common                      1.3.2-2ubuntu0.1                         deb        
libtirpc3                            1.3.2-2ubuntu0.1                         deb        
libtypes-serialiser-perl             1.01-1                                   deb        
libudev1                             249.11-0ubuntu3.10                       deb        
libunistring2                        1.0-1                                    deb        
libuuid1                             2.37.2-4ubuntu3                          deb        
libuv1                               1.43.0-1                                 deb        
libwebp7                             1.2.2-2ubuntu0.22.04.2                   deb        
libx11-6                             2:1.7.5-1ubuntu0.3                       deb        
libx11-data                          2:1.7.5-1ubuntu0.3                       deb        
libxau6                              1:1.0.9-1build5                          deb        
libxcb-render0                       1.14-3ubuntu3                            deb        
libxcb-shm0                          1.14-3ubuntu3                            deb        
libxcb1                              1.14-3ubuntu3                            deb        
libxcomposite1                       1:0.4.5-1build2                          deb        
libxcursor1                          1:1.2.0-2build4                          deb        
libxdamage1                          1:1.1.5-2build2                          deb        
libxdmcp6                            1:1.1.3-0ubuntu5                         deb        
libxext6                             2:1.3.4-1build1                          deb        
libxfixes3                           1:6.0.0-1                                deb        
libxi6                               2:1.8-1build1                            deb        
libxinerama1                         2:1.1.4-3                                deb        
libxml2                              2.9.13+dfsg-1ubuntu0.3                   deb        
libxrandr2                           2:1.5.2-1build1                          deb        
libxrender1                          1:0.9.10-1build4                         deb        
libxslt1.1                           1.1.34-4ubuntu0.22.04.1                  deb        
libxxhash0                           0.8.1-1                                  deb        
libzstd1                             1.4.8+dfsg-3build1                       deb        
locales                              2.35-0ubuntu3.4                          deb        
login                                1:4.8.1-2ubuntu2.1                       deb        
logrotate                            3.19.0-1ubuntu1.1                        deb        
logsave                              1.46.5-2ubuntu1.1                        deb        
lsb-base                             11.1.0ubuntu4                            deb        
lua-lpeg                             1.0.2-1                                  deb        
mawk                                 1.3.4.20200120-3                         deb        
mount                                2.37.2-4ubuntu3                          deb        
mtr                                  0.95-1                                   deb        
ncurses-base                         6.3-2ubuntu0.1                           deb        
ncurses-bin                          6.3-2ubuntu0.1                           deb        
netbase                              6.3                                      deb        
netcat                               1.218-4ubuntu1                           deb        
netcat-openbsd                       1.218-4ubuntu1                           deb        
nmap                                 7.91+dfsg1+really7.80+dfsg1-2ubuntu0.1   deb        
nmap-common                          7.91+dfsg1+really7.80+dfsg1-2ubuntu0.1   deb        
openssl                              3.0.2-0ubuntu1.12                        deb        
passwd                               1:4.8.1-2ubuntu2.1                       deb        
perl                                 5.34.0-3ubuntu1.2                        deb        
perl-base                            5.34.0-3ubuntu1.2                        deb        
perl-modules-5.34                    5.34.0-3ubuntu1.2                        deb        
postgresql                           14+238                                   deb        
postgresql                           14.9                                     binary     
postgresql-14                        14.9-0ubuntu0.22.04.1                    deb        
postgresql-client-14                 14.9-0ubuntu0.22.04.1                    deb        
postgresql-client-common             238                                      deb        
postgresql-common                    238                                      deb        
procps                               2:3.3.17-6ubuntu2                        deb        
publicsuffix                         20211207.1025-1                          deb        
readline-common                      8.1.2-1                                  deb        
rsync                                3.2.7-0ubuntu0.22.04.2                   deb        
sed                                  4.8-1ubuntu2                             deb        
sensible-utils                       0.0.17                                   deb        
shared-mime-info                     2.1-2                                    deb        
ssl-cert                             1.1.2                                    deb        
sysstat                              12.5.2-2ubuntu0.2                        deb        
sysvinit-utils                       3.01-1ubuntu1                            deb        
tar                                  1.34+dfsg-1ubuntu0.1.22.04.1             deb        
tcpdump                              4.99.1-3ubuntu0.1                        deb        
traceroute                           1:2.1.0-2                                deb        
tzdata                               2023c-0ubuntu0.22.04.2                   deb        
ubuntu-keyring                       2021.03.26                               deb        
ubuntu-mono                          20.10-0ubuntu2                           deb        
ucf                                  3.0043                                   deb        
unzip                                6.0-26ubuntu3.1                          deb        
usrmerge                             25ubuntu2                                deb        
util-linux                           2.37.2-4ubuntu3                          deb        
wget                                 1.21.2-2ubuntu1                          deb        
xdg-user-dirs                        0.17-2ubuntu4                            deb        
xz-utils                             5.2.5-2ubuntu1                           deb        
zlib1g                               1:1.2.11.dfsg-2ubuntu9.2                 deb        
```

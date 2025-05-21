# Repo Maintenance

## Overview
- no need to build/push image manually as pipeline will do so when tagged commits are pushed
  - can be any branch
  - can be any format but must start with a 'v'
- [adegoodyer/kubernetes-admin-toolkit](https://hub.docker.com/repository/docker/adegoodyer/kubernetes-admin-toolkit)

## Testing and Documentation Generation
```bash
# make changes to Dockerfile

# build image and test locally
docker build -t kubernetes-admin-toolkit:testing . &&
docker run -it --rm \
--name kubernetes-admin-toolkit-testing \
kubernetes-admin-toolkit:testing

# add/commit Dockerfile changes

# add tags
git tag -a v1.1.4 -m "v1.1.4"

# push tag
git push --follow-tags

# commit/push Dockerfile changes to git

# generate documentation
# won't be able to do until image has been build/pushed
./scripts/generate-docs.sh

# commit/push documentation changes to git
```

## Build and Push Image

```bash
# build image
d build \
-t adegoodyer/kubernetes-admin-toolkit:v1.1.4 \
-t adegoodyer/kubernetes-admin-toolkit:latest .

# sec scan
grype adegoodyer/kubernetes-admin-toolkit:latest

# generate SBOM
syft adegoodyer/kubernetes-admin-toolkit:latest

# cleanup local test containers/images

# push image
d logout && d login --username=adegoodyer
d push adegoodyer/kubernetes-admin-toolkit --all-tags

# test
kat
```

## GitHub Release
```bash
# draft bew release
# https://github.com/adegoodyer/kubernetes-admin-toolkit/releases/new

# choose tag
v1.1.4

# choose title
v1.1.4

# choose description
Release Notes:

Date:   May 21, 2025
Author: Ade Goodyer adriangoodyer@gmail.com

- added nats and telnet CLI tools
- refined docs and README generation
```

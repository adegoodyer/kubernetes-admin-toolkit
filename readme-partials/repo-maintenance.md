# Repo Maintenance

## Overview
- no need to build/push image manually as pipeline will do so when tagged commits are pushed
  - can be any branch
  - can be any format but must start with a 'v'
- [adegoodyer/kubernetes-admin-toolkit](https://hub.docker.com/repository/docker/adegoodyer/kubernetes-admin-toolkit)

## Process
```bash
# make changes to Dockerfile

# build image and test locally
docker build -t kubernetes-admin-toolkit:testing . && \
docker run -it --rm \
--name kubernetes-admin-toolkit-testing \
kubernetes-admin-toolkit:testing

# add/commit Dockerfile changes

# add tag
git tag -a v1.1.1.5 -m "v1.1.5"

# push tag
git push --follow-tags

# commit/push Dockerfile changes to git

# generate documentation
# won't be able to do until image has been build/pushed
./scripts/generate-docs.sh

# commit/push documentation changes to git
```

### Manual Build and Push

```bash
# build image
docker build -t adegoodyer/kubernetes-admin-toolkit:v1.1.5 -t adegoodyer/kubernetes-admin-toolkit:latest .

# sec scan
grype adegoodyer/kubernetes-admin-toolkit:latest

# generate SBOM
syft adegoodyer/kubernetes-admin-toolkit:latest

# push image
docker logout && docker login --username=adegoodyer
docker push adegoodyer/kubernetes-admin-toolkit --all-tags

# verify on Docker Hub
https://hub.docker.com/repository/docker/adegoodyer/kubernetes-admin-toolkit
```

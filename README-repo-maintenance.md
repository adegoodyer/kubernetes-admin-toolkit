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

### Manually Build/Pushing

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

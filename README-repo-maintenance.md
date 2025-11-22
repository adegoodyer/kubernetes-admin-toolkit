# Repo Maintenance
```bash
# create new branch

# make changes to Dockerfile

# build image and test locally
docker build -t kubernetes-admin-toolkit:testing . && \
docker run -it --rm \
--name kubernetes-admin-toolkit-testing \
kubernetes-admin-toolkit:testing

# commit Dockerfile changes

# build image
docker build -t adegoodyer/kubernetes-admin-toolkit:v1.1.6 -t adegoodyer/kubernetes-admin-toolkit:latest .

# sec scan (optional)
grype adegoodyer/kubernetes-admin-toolkit:latest

# generate SBOM (optional)
syft adegoodyer/kubernetes-admin-toolkit:latest

# push image
docker logout && docker login --username=adegoodyer
docker push adegoodyer/kubernetes-admin-toolkit --all-tags

# verify on Docker Hub
https://hub.docker.com/repository/docker/adegoodyer/kubernetes-admin-toolkit

# commit/push Dockerfile changes to git

# generate documentation
# won't be able to do until image has been built/pushed
./scripts/generate-docs.sh

# commit/push documentation changes to git

# merge branch to master and delete

# add tag
git tag -a v1.1.6 -m "v1.1.6"

# push tag
git push --follow-tags

# create release on GitHub
```

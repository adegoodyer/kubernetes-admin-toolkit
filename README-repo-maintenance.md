# Repo Maintenance

## Routine updates (automated)
- **Renovate** opens PRs when the base images, yq, nats or GitHub Actions have new versions.
- **CI** builds each PR for amd64 and arm64 and runs `scripts/smoke-test.sh`. Review and merge if green.
- **Weekly** (Mondays 03:00 UTC) CI rebuilds master to pick up Ubuntu patches and pushes `latest`, `weekly` and `weekly-YYYYMMDD`.

## Making a change
```bash
# create new branch
git switch -c my-change

# make changes to Dockerfile

# build image and test locally
docker build -t kubernetes-admin-toolkit:testing . && \
./scripts/smoke-test.sh kubernetes-admin-toolkit:testing

# interactive check (optional)
docker run -it --rm kubernetes-admin-toolkit:testing

# push branch and open a PR - CI builds and tests both architectures
git push -u origin my-change
gh pr create --fill

# merge PR once CI passes
gh pr merge --squash --delete-branch
```

## Releasing
```bash
git switch master && git pull

# tag - CI builds, tests and pushes vX.Y.Z and latest to Docker Hub
git tag -a v1.2.0 -m "v1.2.0"
git push origin v1.2.0

# create release on GitHub
gh release create v1.2.0 --generate-notes

# verify on Docker Hub
# https://hub.docker.com/repository/docker/adegoodyer/kubernetes-admin-toolkit
```

## One-time setup
- Repo secrets `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` (a Docker Hub access token)
- Install the [Renovate GitHub App](https://github.com/apps/renovate) on this repo

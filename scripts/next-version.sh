#!/usr/bin/env bash
# Works out whether master needs a release, and its version, as GitHub Actions outputs:
#   release=true|false   the Dockerfile changed since the last vX.Y.Z tag
#   version=vX.Y.Z       the next version (only when release=true)
#
# Only the Dockerfile changes what's in the image, so docs, CI and Renovate config changes
# never cause a release. The bump comes from the commit messages since the last release:
#   "[major]", "BREAKING CHANGE" or "type!:"  -> major
#   "[minor]" or a "feat:" prefix             -> minor
#   anything else (e.g. Renovate updates)     -> patch
#
# Usage: ./scripts/next-version.sh >> "$GITHUB_OUTPUT"   (needs full history and tags)
set -euo pipefail

last=$(git tag --list 'v*' --sort=-v:refname | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | head -n1 || true)

if [ -n "$last" ] && git diff --quiet "$last" HEAD -- Dockerfile; then
  echo "Dockerfile unchanged since $last, no release" >&2
  echo "release=false"
  exit 0
fi

IFS=. read -r major minor patch <<< "${last#v}"
major=${major:-0} minor=${minor:-0} patch=${patch:-0}
messages=$(git log --format=%B "${last:+$last..}HEAD")

if grep -qE '\[major\]|BREAKING CHANGE|^[a-z]+(\([^)]*\))?!:' <<< "$messages"; then
  version="v$((major + 1)).0.0"
elif grep -qE '\[minor\]|^feat(\([^)]*\))?:' <<< "$messages"; then
  version="v$major.$((minor + 1)).0"
else
  version="v$major.$minor.$((patch + 1))"
fi

echo "Last release ${last:-none}, next $version" >&2
echo "release=true"
echo "version=$version"

#!/bin/bash
#
# Author:       Ade Goodyer
# Date:         27th April 2024
# Description:  generate README.md file
#

# resolve absolute path of script and cd into that dir
# ensures consistent location wherever script is executed from
WORKING_DIR="$(dirname "$(realpath "$0")")"
cd "$WORKING_DIR" || exit

# source functions
for file in "${WORKING_DIR}/functions/"*.sh; do
  source "$file"
done

# source env
if [ -f "${WORKING_DIR}/.env" ]; then
  source "${WORKING_DIR}/.env"
else
  print_error ".env file not found. Ensure you have copied example and populated required values."
  exit 1
fi

# dependency checks
check_envars "CONTAINER_REPO" "CONTAINER_TAG"
check_toolchain grype syft

printf "\nGenerating Sections..\n"

# @TODO render_title
cat partials/title.md | sed -e "s/{{TITLE}}/$GIT_REPO/g" > README.md

# @TODO fix render_section to handle key-values
render_section "shields"
render_section "overview"
render_section "usage"

# @TODO build before sbom? - to make sure doesn't freeze?
# docker build -t ${CONTAINER_REPO}:${CONTAINER_TAG} ../Dockerfile
render_sbom "${CONTAINER_REPO}:${CONTAINER_TAG}"
render_sec_scan "${CONTAINER_REPO}:${CONTAINER_TAG}"

printf "\nREADME.md generated successfully.\n"

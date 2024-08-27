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

# source shell files
source "${WORKING_DIR}/functions/checks.sh"
source "${WORKING_DIR}/functions/outputs.sh"

# source .env
if [ -f "${WORKING_DIR}/.env" ]; then
  source "${WORKING_DIR}/.env"
else
  print_error ".env file not found. Ensure you have copied example and populated required values."
  exit 1
fi

# initial checks
check_envars "ONE" "TWO"
check_toolchain grype syft

printf "\nGenerating Sections..\n"

# Title
printf " Title..\t\t"
cat partials/title.md >README.md
printf "Done\n"

cat partials/title.md | sed -e "s/{{TITLE}}/$GIT_REPO/g" > README.md

# Shields
printf " Shields..\t\t"
cat partials/shields.md >>README.md
printf "Done\n"

# Overview
printf " Overview..\t\t"
cat partials/overview.md >>README.md
printf "Done\n"

# Usage
printf " Generating Usage..\t"
cat partials/usage.md >>README.md
printf "Done\n"

# # SBOM
# printf 'Generating SBOM..\n'
# printf '\n## SBOM\n\n```bash\n' >>README.md
# syft scan adegoodyer/kubernetes-admin-toolkit:"${KAT_VERSION}" >>README.md
# printf '```\n' >>README.md
# printf "Done\n"
#
# # Security Scan
# printf "Scanning packages..\n"
# printf '\n## Security Scan\n\n```bash\n' >>README.md
# grype adegoodyer/kubernetes-admin-toolkit:"${KAT_VERSION}" >>README.md
# printf '```\n' >>README.md
# printf "Done\n"

printf "\nREADME.md generated successfully.\n"

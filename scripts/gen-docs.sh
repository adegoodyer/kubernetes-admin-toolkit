#!/bin/bash
# generates the README.md file for the project

# Intro
cat documentation/readme-partials/intro > README.md

# Security Scan
printf '\n## Security Scan\n```bash\n' >> README.md
grype adegoodyer/kubernetes-admin-toolkit:latest | tee -a README.md
printf '```\n' >> README.md

# SMOB
printf '\n## SBOM\n```bash\n' >> README.md
syft adegoodyer/kubernetes-admin-toolkit:latest | tee -a README.md
printf '```\n' >> README.md

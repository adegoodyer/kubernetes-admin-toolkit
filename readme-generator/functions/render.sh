# generate sbom and append it to README.md
# takes container in format repo:tag as input
render_sbom() {
  local container="$1"
  local readme_file="README.md"

  printf 'Generating SBOM..\n'
  printf '\n## SBOM\n\n```bash\n' >> "$readme_file"
  syft scan "$container" >> "$readme_file"
  printf '```\n' >> "$readme_file"
  printf "Done\n"
}

# perform sec scan and append it to README.md
# takes container in format repo:tag as input
render_sec_scan() {
  local container="$1"
  local readme_file="README.md"

  printf "Scanning packages..\n"
  printf '\n## Security Scan\n\n```bash\n' >> "$readme_file"
  grype "$container" >> "$readme_file"
  printf '```\n' >> "$readme_file"
  printf "Done\n"
}

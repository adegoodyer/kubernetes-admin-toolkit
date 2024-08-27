#!/bin/bash

# check if specified environment variable is set or empty
# prompt if either checks fail
check_envar() {
  local var_name="$1"
  local var_value="${!var_name}"

  # Check if the variable is unset or empty
  if [ -z "$var_value" ]; then
    print_error "The environment variable $var_name is either not set or empty."
    read -rp "Enter a value for $var_name: " var_value
    export "$var_name=$var_value"
  fi
}

check_toolchain() {
local tools=("$@")

for cmd in "${tools[@]}"; do
  if ! command -v "$cmd" &> /dev/null; then
    print_error "$cmd is not installed. Please install $cmd before re-running."
    exit 1
  fi
done
}

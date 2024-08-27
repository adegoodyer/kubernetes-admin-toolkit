#!/bin/bash

# check if envars have been set and are not empty
# prompt if either check fails
check_envars() {
  local var_names=("$@")
  
  for var_name in "${var_names[@]}"; do
    local var_value="${!var_name}"
    
    # Check if the variable is unset or empty
    if [ -z "$var_value" ]; then
      print_error "The environment variable $var_name is either not set or empty."
      read -rp "Enter a value for $var_name: " var_value
      export "$var_name=$var_value"
    fi
  done
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

#!/bin/bash

# print error messages with "Error:" in red
print_error() {
    local message="$1"
    printf "\n\033[31mError:\033[0m %s\n" "$message"
}


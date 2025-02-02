#!/usr/bin/env bash

dir="$1"
[[ ! -d "$dir" ]] && exit 1

# Colors
blue="\033[1;34m"
cyan="\033[1;36m"
dim="\033[2m"
reset="\033[0m"

# Get and format directory size
size=$(du -sh "$dir" 2>/dev/null | cut -f1)
printf "${dim}┌ %s%s${reset}\n" "$(basename "$dir")" " $size"

# Directory contents
eza --color=always --icons --git --group-directories-first "$dir"

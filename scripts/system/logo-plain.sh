#!/usr/bin/env bash

# Clear the screen completely
clear

# Hide the cursor
tput civis

# Trap Ctrl+C to restore cursor and exit cleanly
trap 'tput cnorm; clear; exit 0' INT

# Print the logo
printf "\e[38;2;244;241;230mculture\e[0m"
printf "\e[48;2;244;241;230m\e[38;2;37;35;34mcode\e[0m\n"

# Wait silently ‚Äî terminal appears frozen
while :; do sleep 86400; done

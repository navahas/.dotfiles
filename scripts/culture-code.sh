#!/usr/bin/env bash

# Clear the screen completely
clear

# Hide the cursor
tput civis

# Trap Ctrl+C to restore cursor and exit cleanly
trap 'tput cnorm; clear; exit 0' INT

# Print the logo
printf "\e[38;2;244;241;230mculture\e[0m"
printf "\e[48;2;195;187;227m \e[0m"
printf "\e[48;2;255;214;160m \e[0m"
printf "\e[48;2;183;234;197m \e[0m"
printf "\e[48;2;245;124;115m \e[0m\n"

printf "\e[48;2;244;241;230m\e[38;2;37;35;34m       code\e[0m\n"

# Wait silently — terminal appears frozen
while :; do sleep 86400; done

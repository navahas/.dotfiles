#!/usr/bin/env bash

bold=""

if [[ "$1" == "--bold" ]]; then
    bold="1;"
fi

# Clear screen
clear

# Hide cursor
tput civis

# Restore cursor and clean on Ctrl+C
trap 'tput cnorm; clear; exit 0' INT

# Print "culture"
printf "\e[${bold}38;2;244;241;230mculture\e[0m"
printf "\e[${bold}48;2;244;241;230m\e[38;2;37;35;34mcode\e[0m\n"

# Print color blocks (Lavender, Peach, Mint, Coral)
printf "       "

# Lavender
printf "\e[38;2;195;187;227m▀\e[0m"
# "\e[38;2;195;187;227m▀\e[0m"

# Peach
printf "\e[38;2;250;209;163m▀\e[0m"
# "\e[38;2;255;214;160m▀\e[0m"

# Mint
printf "\e[38;2;204;235;177m▀\e[0m"
# "\e[38;2;183;234;197m▀\e[0m"

# Coral
printf "\e[38;2;240;119;119m▀\e[0m\n"
# "\e[38;2;245;124;115m▀\e[0m\n"

# Print "code" block on bone background

# Keep screen until Ctrl+C
while :; do sleep 86400; done

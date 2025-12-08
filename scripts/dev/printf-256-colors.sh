#!/usr/bin/env bash

for i in {0..255}; do
    printf "\e[48;5;${i}m%3d " "$i"
    if (( (i+1) % 16 == 0 )); then
        printf "\e[0m\n"
    fi
done
printf "\e[0m\n"


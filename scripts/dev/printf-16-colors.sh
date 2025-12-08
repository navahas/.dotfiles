#!/usr/bin/env bash

for i in {30..37}; do
    echo -e "\e[${i}mColor ${i}\e[0m"
done

for i in {90..97}; do
    echo -e "\e[${i}mBright Color ${i}\e[0m"
done

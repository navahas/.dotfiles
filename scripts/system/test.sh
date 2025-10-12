#!/usr/bin/env bash

custom_command='ps -A -o %cpu | awk "{s+=\$1} END {print s \"%\"}"'

cpu_usage=$(bash -c "$custom_command")

echo "CPU: $cpu_usage, $(date '+%Y-%m-%d %H:%M:%S')"

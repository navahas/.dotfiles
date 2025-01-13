#!/usr/bin/env bash

if [[ ! -f ~/.ssh/config ]]; then
    echo "Error: ~/.ssh/config not found" >&2
    exit 1
fi

host=$(grep "^Host " ~/.ssh/config | awk '{print $2}' | fzf --header="SSH HOSTS")
if [ -n "$host" ]; then
    exec ssh "$host"
fi

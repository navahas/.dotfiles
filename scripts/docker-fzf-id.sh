#!/usr/bin/env bash

container_id=$(docker ps -a | \
    awk 'NR>1 {print $1, $2, $NF}' | \
    fzf --preview 'docker logs --tail 100 {1}' \
    --preview-window right:60%:wrap | \
    awk '{print $1}')

if [[ -n "$container_id" ]]; then
    echo -n "$container_id" | pbcopy
    echo "Container ID copied to clipboard: $container_id"
    exit 0
else
    echo "No container selected"
    exit 1
fi

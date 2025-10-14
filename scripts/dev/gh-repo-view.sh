#!/usr/bin/env bash

gh_username="${1:-}"
# gh repo list -L 999 "$gh_username" | fzf --multi | awk '{print $1}' | xargs -r -I {} gh repo view {} --web

gh repo list "$gh_username" -L 999 --json name,updatedAt \
  | jq -r --arg user "$gh_username" '.[] | [(if $user == "" then .name else $user + "/" + .name end), (.updatedAt | fromdateiso8601 | strftime("%d/%m/%Y  %H:%M"))] | @tsv' \
  | awk -F'\t' '{
      gray="\x1b[32m"
      reset="\x1b[0m"
      printf "%-45s %s%s%s\n", $1, gray, $2, reset
  }' \
  | fzf --color fg:dim,fg+:regular \
    --multi --ansi \
    --style full \
    --prompt="[github]> " \
    --list-border --input-border \
    --color=header:#A2A197,header-label:#e7e7d3,header-border:,input-label:#e7e7d3,list-border:#c67c67,pointer:#c67c67,prompt:#c67c67\
  | awk '{print $1}' \
  | xargs -r -I {} gh repo view {} --web

#!/usr/bin/env bash

gh_username="${1:-}"
# gh repo list -L 999 "$gh_username" | fzf --multi | awk '{print $1}' | xargs -r -I {} gh repo view {} --web

gh repo list "$gh_username" -L 999 --json name,updatedAt \
  | jq -r --arg user "$gh_username" '.[] | [(if $user == "" then .name else $user + "/" + .name end), (.updatedAt | fromdateiso8601 | strftime("%d/%m/%Y  %H:%M"))] | @tsv' \
  | awk -F'\t' '{
      gray="\x1b[30m"
      reset="\x1b[0m"
      printf "%-45s %s%s%s\n", $1, gray, $2, reset
  }' \
  | fzf --multi --header="REPO" --ansi \
  | awk '{print $1}' \
  | xargs -r -I {} gh repo view {} --web

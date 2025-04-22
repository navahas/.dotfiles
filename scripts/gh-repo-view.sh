#!/usr/bin/env bash

gh_username="${1:-}"
gh repo list -L 999 "$gh_username" | fzf | awk '{print $1}' | xargs -r -I {} gh repo view {} --web

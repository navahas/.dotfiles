#!/usr/bin/env bash

gh_username="${1:-}"

if [[ -z "$gh_username" ]]; then
    echo "You need to provide a GitHub username!"
    echo "ghrepo-user <username>"
    exit 0
fi

gh api -X GET "search/users?q=$gh_username+in:login" --jq '.items[].login' \
      | fzf --prompt="Select GitHub user: " \
      | xargs -r -I {} "$HOME/.local/scripts/gh-repo-view.sh" {}

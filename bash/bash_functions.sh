#!/usr/bin/env bash
# Custom functions

# Change directory using fzf
cdf() {
    local selected_dir=$(bash "$HOME/.local/scripts/cd-fzf.sh")
    if [ -n "$selected_dir" ]; then
        cd "$selected_dir" || return
    fi
}

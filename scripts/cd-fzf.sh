#!/usr/bin/env bash

search_dirs=("$HOME/.dotfiles" "$HOME/.config" "$HOME/.ssh" "$HOME/.local")
search_dirs+=($(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d 2>/dev/null))

selected_dir=$( { \
    find "${search_dirs[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null; \
    ls -d ~/* ~/.* 2>/dev/null | grep -v "^\.$\|^\.\.$"; \
} | fzf)

if [[ -n $selected_dir && -d $selected_dir ]]; then
    cd "$selected_dir" || exit 1
fi

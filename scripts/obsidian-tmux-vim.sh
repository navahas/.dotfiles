#!/usr/bin/env bash

obsidian_path="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"
session_name="obsidian"

if tmux has-session -t=$session_name 2>/dev/null; then
    [[ -z $TMUX ]] && tmux attach-session -t $session_name || tmux switch-client -t $session_name
else
    tmux new-session -d -s $session_name -c "$obsidian_path"
    [[ $1 == "--vim" ]] && tmux send-keys -t $session_name:0 "nvim ." C-m
    [[ -z $TMUX ]] && tmux attach-session -t $session_name || tmux switch-client -t $session_name
fi

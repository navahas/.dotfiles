#!/usr/bin/env bash

# This script is meant to simplify opening a lazy git window within tmux
command -v lazygit &> /dev/null

git rev-parse --is-inside-work-tree &> /dev/null

# Allow optional arguments for the tmux window name
WINDOW_NAME=${1:-git}

# Make sure you are in the git project path
CURRENT_PATH=$(tmux display-message -p "#{pane_current_path}")

# Check if the tmux window already exists as a cmd shortcut to jump always using the bind
EXISTING_WINDOW=$(tmux list-windows | grep -w "git" | cut -d: -f1)

if [ -n "${EXISTING_WINDOW}" ]; then
    tmux select-window -t "${EXISTING_WINDOW}"
else
    tmux new-window -n "${WINDOW_NAME}" -c "${CURRENT_PATH}" "lazygit"
fi

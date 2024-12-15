#!/usr/bin/env bash

# Step 1: Define the directories to search
search_dirs=(
    "$HOME/.dotfiles"
    "$HOME/.config"
)

# Add all subdirectories from $HOME/development dynamically
development_dirs=$(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d)
search_dirs+=($development_dirs)

open_nvim=false
selected=""

# Parse arguments
for arg in "$@"; do
    if [[ $arg == "--vi" ]]; then
        open_nvim=true
    else
        selected=$arg
    fi
done

# If no directory is passed, use fzf to select one
if [[ -z $selected ]]; then
    selected=$(find "${search_dirs[@]}" -mindepth 1 -maxdepth 1 -type d | fzf)
fi

# Exit if no directory is selected
if [[ -z $selected ]]; then
    exit 0
fi

# Step 2: Create a tmux session name from the selected directory
selected_name=$(basename "$selected" | tr . _)

# Step 3: Check if the session exists
if tmux has-session -t=$selected_name 2> /dev/null; then
    # If session exists, attach or switch to it
    if [[ -z $TMUX ]]; then
        # Outside tmux: Attach to the session
        tmux attach-session -t $selected_name
    else
        # Inside tmux: Switch to the session
        tmux switch-client -t $selected_name
    fi
else
    # If session does not exist, create a new one
    if [[ -z $TMUX ]]; then
        # Outside tmux:
        tmux new-session -d -s $selected_name -c $selected
        # Run nvim if the --vi flag is provided
        if $open_nvim; then
            tmux send-keys -t $selected_name "nvim ." C-m
        fi
        tmux attach-session -t $selected_name
    else
        # Inside tmux:
        tmux new-session -ds $selected_name -c $selected
        if $open_nvim; then
            tmux send-keys -t $selected_name "nvim ." C-m
        fi
        tmux switch-client -t $selected_name
    fi

fi

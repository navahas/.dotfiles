#!/usr/bin/env bash

# Step 1: Define the directories to search
search_dirs=(
    "$HOME/.dotfiles"
    "$HOME/.config"
)

# Add all subdirectories from $HOME/development dynamically
development_dirs=$(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d)
search_dirs+=($development_dirs)

normal_shell=false
selected=""

# Parse arguments
for arg in "$@"; do
    if [[ $arg == "--n" ]]; then
        normal_shell=true
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
    # If session exists, attach or switch based on context
    [[ -z $TMUX ]] && tmux attach-session -t $selected_name || tmux switch-client -t $selected_name
else
    # If session doesn't exist, create it
    if ! $normal_shell; then
        # Create session and run `nvim .`
        tmux new-session -d -s $selected_name -c $selected
        tmux send-keys -t $selected_name:0 "nvim ." C-m
    else
        # Create session without running `nvim .`
        tmux new-session -s $selected_name -c $selected
    fi

    # Attach or switch based on context
    [[ -z $TMUX ]] && tmux attach-session -t $selected_name || tmux switch-client -t $selected_name
fi

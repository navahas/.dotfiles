#!/usr/bin/env bash

ghosttymux() {
    # Define search directories
    local search_dirs=("$HOME/.dotfiles" "$HOME/.config")
    search_dirs+=($(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d 2>/dev/null))
    
    # Select a directory
    local selected_dir
    selected_dir=$(
        find "${search_dirs[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | fzf
    )
    [[ -z $selected_dir || ! -d $selected_dir ]] && exit 1
    
    cd "$selected_dir" || return 1

    # Generate a name for the tmux session path-based 
    local session_name
    session_name=$(basename "$selected_dir" | tr . _)

    # Handle tmux session
    if tmux has-session -t=$session_name 2>/dev/null; then
        [[ -z $TMUX ]] && tmux attach-session -t $session_name || tmux switch-client -t $session_name
    else
        tmux new-session -d -s $session_name -c "$selected_dir"
        tmux send-keys -t $session_name:0 "nvim ." C-m
        [[ -z $TMUX ]] && tmux attach-session -t $session_name || tmux switch-client -t $session_name
    fi
}

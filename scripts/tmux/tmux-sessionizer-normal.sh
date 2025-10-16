#!/usr/bin/env bash

# Define search directories
# For .dotfiles and .config, we'll search inside them
search_inside=("$HOME/.dotfiles" "$HOME/.config")
# For these dirs, we want them directly selectable
direct_dirs=("$HOME/nix-config")
# Add dev subdirectories
search_inside+=($(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d 2>/dev/null))

# header="
# ███████╗███████╗███████╗███████╗██╗ ██████╗ ███╗   ██╗██╗███████╗███████╗██████╗ 
# ██╔════╝██╔════╝██╔════╝██╔════╝██║██╔═══██╗████╗  ██║██║╚══███╔╝██╔════╝██╔══██╗
# ███████╗█████╗  ███████╗███████╗██║██║   ██║██╔██╗ ██║██║  ███╔╝ █████╗  ██████╔╝
# ╚════██║██╔══╝  ╚════██║╚════██║██║██║   ██║██║╚██╗██║██║ ███╔╝  ██╔══╝  ██╔══██╗
# ███████║███████╗███████║███████║██║╚██████╔╝██║ ╚████║██║███████╗███████╗██║  ██║
# ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝"

session_count=$(tmux list-sessions 2>/dev/null | wc -l | tr -d ' ')
pane_count=$(tmux list-panes -a 2>/dev/null | wc -l | tr -d ' ')
header="  tmux sessionizer — normal | sessions: $session_count | panes: $pane_count "

# Select a directory
selected_dir=$(
{
    find "${search_inside[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null
    printf '%s\n' "${direct_dirs[@]}"
} |
    fzf --color fg:dim,fg+:regular \
    --style full \
    --prompt='[picker]> ' \
    --header="" --header-first --header-label="$header" --header-label-pos=bottom \
    --list-border --input-border \
    --preview '$HOME/.local/scripts/fzf/fzf-preview-01.sh {}' \
    --preview-window 'right:30%:wrap' --preview-label ' files ' \
    --color=header:#A2A197,header-label:#e7e7d3,header-border:,input-label:#e7e7d3,list-border:#c67c67,pointer:#c67c67,prompt:#c67c67,preview-label:#e7e7d3

)
[[ -z $selected_dir || ! -d $selected_dir ]] && exit 1

cd "$selected_dir" || return 1

# Generate a name for the tmux session path-based 
session_name=$(basename "$selected_dir" | tr . _)

# Handle tmux session
if tmux has-session -t=$session_name 2>/dev/null; then
    [[ -z $TMUX ]] && tmux attach-session -t $session_name || tmux switch-client -t $session_name
else
    tmux new-session -d -s $session_name -c "$selected_dir"
    [[ -z $TMUX ]] && tmux attach-session -t $session_name || tmux switch-client -t $session_name
fi

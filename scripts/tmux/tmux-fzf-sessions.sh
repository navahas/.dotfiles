#!/usr/bin/env bash

if [ -z "$(tmux list-sessions 2>/dev/null)" ]; then
    echo "no tmux sessions found"
    exit 0
fi

# header="
# ████████╗███╗   ███╗██╗   ██╗██╗   ██╗
# ╚══██╔══╝████╗ ████║██║   ██║ ██╗ ██╔╝
#    ██║   ██╔████╔██║██║   ██║  ████╔╝ 
#    ██║   ██║╚██╔╝██║██║   ██║ ██╔═██╗ 
#    ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝  ██╗
#    ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝   ╚═╝"


session_windows=$(tmux list-windows -a -F "#{session_name}:#{window_index} - #{window_name}")

selected=$(echo "$session_windows" | fzf -m \
    --style full \
    --header="" --header-label-pos=bottom --header-label '  tmux session — fzf ' \
    --header-first \
    --prompt='[picker]> ' \
    --layout=reverse \
    --input-border \
    --list-border \
    --preview-window="right:75%" \
    --preview-border --preview-label ' preview ' \
    --bind '?:toggle-preview' \
    --tiebreak=begin \
    --preview='tmux capture-pane -e -t {1} -p' \
    --color=header:#dcdccc,prompt:#c67c67,header-label:#e7e7d3,list-border:#c67c67,preview-label:#e7e7d3,pointer:#c67c67
)

if [ -z "$selected" ]; then
    echo "no tmux session selected"
    exit 0
fi

selected_count=$(echo "$selected" | wc -l)

if [ "$selected_count" -gt 1 ]; then
    echo "$selected" | tac | while read -r line; do
        target=$(echo "$line" | cut -d' ' -f1)
        tmux kill-window -t "$target" 2>/dev/null || true
    done
else
    target=$(echo "$selected" | cut -d' ' -f1)
    if [ -z "$TMUX" ]; then
        tmux attach-session -t "$target"
    else
        tmux switch-client -t "$target"
    fi
fi

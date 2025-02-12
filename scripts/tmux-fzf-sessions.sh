#!/usr/bin/env bash

# Not needed due to buoyshell plugin update there's no persistent session
selected_sessions=$(tmux list-sessions -F "#{session_name}" | \
    fzf -m \
    --color fg:dim,fg+:regular \
    --style minimal \
    --list-border --list-label '  tmux sessions ' \
    --preview-window "bottom:70%" \
    --preview-border \
    --preview 'tmux capture-pane -e -t {}:$(tmux list-windows -t {} -F "#{window_active} #{window_index}" | grep "^1" | cut -d" " -f2) -p'
)

[ -z "$selected_sessions" ] && exit 0

if [ $(echo "$selected_sessions" | wc -l) -gt 1 ]; then
    echo "$selected_sessions" | while read -r session; do
        tmux kill-session -t "$session"
    done
else
    [ -z "$TMUX" ] && tmux attach-session -t "$selected_sessions" || tmux switch-client -t "$selected_sessions"
fi

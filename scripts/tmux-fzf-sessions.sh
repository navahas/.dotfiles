#!/usr/bin/env bash

# Not needed due to buoyshell plugin update there's no persistent session
if [ -z "$(tmux list-sessions 2>/dev/null)" ]; then
    echo "no tmux sessions found"
    exit 0
fi

selected_sessions=$(tmux list-sessions -F "#{session_name}" | \
    fzf -m \
    --color fg:dim,fg+:regular \
    --style minimal \
    --list-border --list-label '  tmux sessions ' \
    --preview-window "bottom:70%" \
    --preview-border \
    --preview 'tmux capture-pane -e -t {}:$(tmux list-windows -t {} -F "#{window_active} #{window_index}" | grep "^1" | cut -d" " -f2) -p'
)

if [ -z "$selected_sessions" ]; then
    echo "no tmux session selected"
    exit 0
fi

if [ $(echo "$selected_sessions" | wc -l) -gt 1 ]; then
    echo "$selected_sessions" | while read -r session; do
        tmux kill-session -t "$session"
    done
else
    [ -z "$TMUX" ] && tmux attach-session -t "$selected_sessions" || tmux switch-client -t "$selected_sessions"
fi

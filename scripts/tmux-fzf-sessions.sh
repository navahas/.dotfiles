#!/usr/bin/env bash

manager_session="_buoyshell-manager"
selected_sessions=$(tmux list-sessions -F "#{session_name}" | \
    grep -v "^$manager_session$" | \
    fzf -m --preview 'tmux capture-pane -e -t {}:$(tmux list-windows -t {} -F "#{window_active} #{window_index}" | grep "^1" | cut -d" " -f2) -p')

[ -z "$selected_sessions" ] && exit 0

if [ $(echo "$selected_sessions" | wc -l) -gt 1 ]; then
    echo "$selected_sessions" | while read -r session; do
        tmux kill-session -t "$session"
        tmux list-windows -t "$manager_session" -F "#{window_name}" | grep -q "^$session$" && \
            tmux kill-window -t "$manager_session:$session"
    done
else
    [ -z "$TMUX" ] && tmux attach-session -t "$selected_sessions" || tmux switch-client -t "$selected_sessions"
fi

#!/usr/bin/env bash

selected_session=$(tmux list-sessions -F "#{session_name}" | \
   fzf --preview 'tmux capture-pane -e -t {}:$(tmux list-windows -t {} -F "#{window_active} #{window_index}" | grep "^1" | cut -d" " -f2) -p' \
   --preview-window=right:50%)

if [ -z "$selected_session" ]; then
    exit 0
fi

if [ -z "$TMUX" ]; then
    tmux attach-session -t "$selected_session"
else
    tmux switch-client -t "$selected_session"
fi

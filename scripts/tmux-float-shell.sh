#!/usr/bin/env bash

# Define a unique session name for the popup
session_name="popup_manager"

# Get the current session name (parent session, even in a popup)
current_session=$(tmux display-message -p '#{client_session}')

# Check if the popup session already exists
tmux has-session -t "$session_name" 2>/dev/null

if [[ "$current_session" == "$session_name" ]]; then
    exit 0
fi

# Create the session if it doesn't exist
if [[ $? -ne 0 ]]; then
  TMUX='' tmux new-session -d -s "$session_name"
fi

# Define the window name for the current session
window_name="$current_session"

# Get the working directory of the current session
session_dir=$(tmux display-message -t "$current_session" -p '#{pane_current_path}')

# Check if a window for the current session already exists in the popup session
if ! tmux list-windows -t "$session_name" -F '#{window_name}' | grep -q "^$window_name$"; then
  # Create a new window in the popup session for the current session
  tmux new-window -d -t "$session_name" -n "$window_name" -c "$session_dir"
fi

# Attach to the popup session in a popup and switch to the current session's pane
tmux display-popup -E -d '#{pane_current_path}' -xC -yC -w80% -h80% -T " session: $current_session " \
  "tmux attach-session -t '$session_name' \; select-window -t '$current_session'"

#!/usr/bin/env bash

# Define the session file
SESSION_FILE="$HOME/.config/ghostty/ghostty_sessions"

# Get the current path
CURRENT_PATH=$(pwd)

# Function to generate a session ID
generate_session_id() {
  echo "$CURRENT_PATH" | sha1sum | awk '{print $1}'
}

# Check if session file exists, create it if not
if [ ! -f "$SESSION_FILE" ]; then
  touch "$SESSION_FILE"
fi

# Check for an existing session for the current path
SESSION_ID=$(grep "^$CURRENT_PATH=" "$SESSION_FILE" | cut -d'=' -f2)

if [ -z "$SESSION_ID" ]; then
  # No session exists for this path, create a new one
  SESSION_ID=$(generate_session_id)
  echo "$CURRENT_PATH=$SESSION_ID" >> "$SESSION_FILE"
  echo "Created new session for path: $CURRENT_PATH"
else
  echo "Attaching to existing session for path: $CURRENT_PATH"
fi

export GHOSTTY_SESSION_ID="$SESSION_ID"

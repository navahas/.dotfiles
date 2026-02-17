#!/usr/bin/env bash
# Key bindings

# Note: Bash uses readline for key bindings, which is different from Fish
# Some bindings may need adjustment based on your terminal

# Alt+u: Clear screen and show date/time
bind -x '"\eu":"clear; date \"+%H:%M %d-%m-%Y\""'

# Ctrl+ñ: Open nvim in current directory
# Note: This binding might not work in all terminals due to special character
bind -x '"\C-ñ":"nvim ."'

# Ctrl+v: Run tmux-sessionizer-v2-vim
bind -x '"\C-v":"$HOME/.local/scripts/tmux/tmux-sessionizer-vim.sh"'

# Ctrl+n: Run tmux-sessionizer-v2-normal
# bind -x '"\C-n":"$HOME/.local/scripts/tmux/tmux-sessionizer-normal.sh"'

# Ctrl+s: Run tmux-fzf-sessions
bind -x '"\C-s":"$HOME/.local/scripts/tmux/tmux-fzf-sessions.sh"'

# Ctrl+t: Attach to tmux or show message
bind -x '"\C-t":"tmux list-sessions 2>/dev/null | grep -q . && tmux attach || echo \"no tmux sessions found\""'

# Ctrl+x: Edit command in editor (uses $EDITOR)
# This is similar to fish's edit_command_buffer
# Note: In bash, Ctrl+x Ctrl+e already does this by default (readline command: edit-and-execute-command)
bind '"\C-x":"\C-x\C-e"'

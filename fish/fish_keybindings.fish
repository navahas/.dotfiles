#!/usr/bin/env fish
# Key bindings

# Alt+u: Clear screen and show date/time
bind \eu 'clear; date "+%H:%M %d-%m-%Y"'

# Ctrl+ñ: Open nvim in current directory
bind ctrl-ñ 'nvim .'

# Ctrl+v: Run tmux-sessionizer-v2-vim
bind ctrl-V 'tmux-sessionizer-v2-vim; commandline -f repaint'

# Ctrl+n: Run tmux-sessionizer-v2-normal
bind ctrl-N 'tmux-sessionizer-v2-normal; commandline -f repaint'

# Ctrl+s: Run tmux-fzf-sessions
bind ctrl-S 'tmux-fzf-sessions; commandline -f repaint'

# Ctrl+t: Attach to tmux or show message
bind ctrl-T 'tmux list-sessions 2>/dev/null | grep -q . && tmux attach || echo "no tmux sessions found"; commandline -f repaint'

# Ctrl+x: Edit command in editor
bind \cx edit_command_buffer

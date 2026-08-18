#!/bin/bash
# Source environment from fish/bash
if [ -f "$HOME/.config/fish/fish_exports.fish" ]; then
    source "$HOME/.dotfiles/bash/bash_exports.sh" 2>/dev/null || true
fi
exec rofi -show drun

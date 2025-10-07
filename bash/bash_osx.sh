#!/usr/bin/env bash
# macOS-specific configuration

# Check if eza is available and set aliases accordingly
if command -v eza &>/dev/null; then
    alias ell="eza -l -g --icons"
    alias ella="ell -a"
fi

# Ghostty shell integration
if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
    if [ -f "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash" ]; then
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
    fi
fi

# OrbStack integration
if [ -f "$HOME/.orbstack/shell/init.bash" ]; then
    source "$HOME/.orbstack/shell/init.bash" 2>/dev/null || :
fi

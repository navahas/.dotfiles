#!/usr/bin/env bash
# Environment variables and PATH configuration

# Shell configuration
export SHELL=/usr/local/bin/bash
export EDITOR=nvim
export VISUAL=nvim

# Tool configuration
export HOMEBREW_NO_AUTO_UPDATE=1
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export EZA_CONFIG_DIR="$HOME/.config/eza"
export BAT_THEME="Visual Studio Dark+"
export FZF_DEFAULT_OPTS='--reverse'
export WASMTIME_HOME="$HOME/.wasmtime"

# Build PATH in the correct order (most specific first)
# Note: We prepend to PATH, so we add in reverse priority order

# System paths (lowest priority)
export PATH="/sbin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Package managers
export PATH="/nix/var/nix/profiles/default/bin:$PATH"

# Applications
export PATH="/Applications/Ghostty.app/Contents/ghostty:$PATH"
export PATH="/Applications/Ghostty.app/Contents/MacOS:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Homebrew
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Development tools
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.foundry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Local binaries (highest priority)
export PATH="$HOME/.local/bin:$PATH"

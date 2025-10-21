#!/usr/bin/env bash
# Environment variables and PATH configuration

# Shell configuration
# export SHELL=/usr/local/bin/bash
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

# Helper function to add path only if it's not already in PATH
# This prevents duplicates when config is sourced multiple times
add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

# Build PATH in the correct order (most specific first)
# Note: We prepend to PATH, so we add in reverse priority order
# New path gets searched first (higher priority)
# Using add_to_path helper to prevent duplicates when config is re-sourced
#
# Philosophy: Nix-managed packages take precedence over Homebrew and system packages
# to ensure declarative, reproducible tool versions are used.
#
# Note: nix-darwin already sets up Nix paths via /etc/static/bashrc
# The add_to_path function will skip paths that already exist.

# System paths (lowest priority)
# Note: nix-darwin already adds these, add_to_path will skip if they exist
add_to_path "/sbin"
add_to_path "/usr/sbin"
add_to_path "/bin"
add_to_path "/usr/bin"
add_to_path "/usr/local/bin"

# Applications
add_to_path "/Applications/Ghostty.app/Contents/ghostty"
add_to_path "/Applications/Ghostty.app/Contents/MacOS"
add_to_path "/Applications/Docker.app/Contents/Resources/bin"

# Homebrew (supplementary packages and GUI apps)
# Note: Homebrew may already be in PATH from nix-darwin or brew shellenv
add_to_path "/opt/homebrew/sbin"
add_to_path "/opt/homebrew/bin"

# Development tools (language-specific toolchains)
add_to_path "$HOME/.local/share/solana/install/active_release/bin"
add_to_path "$HOME/.foundry/bin"
add_to_path "$HOME/.cargo/bin"

# Nix package manager paths (declarative package management)
# Priority among Nix (lowest to highest):
#   1. System-wide default profile (all users)
#   2. nix-darwin (declarative macOS system config)
#   3. home-manager (declarative user environment)
#   4. User alternative profile location
#   5. User standard profile (imperative user packages)
# These paths have higher priority than Homebrew to ensure reproducible, pinned versions
# Note: nix-darwin already adds these, add_to_path will skip if they exist
add_to_path "/nix/var/nix/profiles/default/bin"  # System-wide default Nix profile
add_to_path "/run/current-system/sw/bin"  # nix-darwin: declarative macOS system configuration
add_to_path "/etc/profiles/per-user/$USER/bin"  # home-manager: declarative user packages & dotfiles
add_to_path "$HOME/.local/share/nix/profile/bin"  # Alternative user profile location
add_to_path "$HOME/.nix-profile/bin"  # Standard user Nix profile (nix-env installations)

# Local binaries (highest priority - user overrides)
add_to_path "$HOME/.local/bin"

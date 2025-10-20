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

# Build PATH in the correct order (most specific first)
# Note: We prepend to PATH, so we add in reverse priority order
# New path gets searched first (higher priority)
#
# Philosophy: Nix-managed packages take precedence over Homebrew and system packages
# to ensure declarative, reproducible tool versions are used.

# System paths (lowest priority)
export PATH="/sbin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Applications
export PATH="/Applications/Ghostty.app/Contents/ghostty:$PATH"
export PATH="/Applications/Ghostty.app/Contents/MacOS:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Homebrew (supplementary packages and GUI apps)
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Development tools (language-specific toolchains)
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.foundry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Nix package manager paths (declarative package management)
# Priority among Nix (lowest to highest):
#   1. System-wide default profile (all users)
#   2. nix-darwin (declarative macOS system config)
#   3. home-manager (declarative user environment)
#   4. User alternative profile location
#   5. User standard profile (imperative user packages)
# These paths have higher priority than Homebrew to ensure reproducible, pinned versions
export PATH="/nix/var/nix/profiles/default/bin:$PATH"  # System-wide default Nix profile
export PATH="/run/current-system/sw/bin:$PATH"  # nix-darwin: declarative macOS system configuration
export PATH="/etc/profiles/per-user/$USER/bin:$PATH"  # home-manager: declarative user packages & dotfiles
export PATH="$HOME/.local/share/nix/profile/bin:$PATH"  # Alternative user profile location
export PATH="$HOME/.nix-profile/bin:$PATH"  # Standard user Nix profile (nix-env installations)

# Local binaries (highest priority - user overrides)
export PATH="$HOME/.local/bin:$PATH"

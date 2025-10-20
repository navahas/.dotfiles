#!/usr/bin/env fish
# Environment variables and PATH configuration

# Shell configuration
# set -x SHELL /usr/local/bin/fish

# Editor configuration
set -gx EDITOR nvim
set -gx VISUAL nvim

# Tool configuration
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx NVM_DIR $HOME/.nvm
set -gx EZA_CONFIG_DIR $HOME/.config/eza
set -gx BAT_THEME "Visual Studio Dark+"
set -gx FZF_DEFAULT_OPTS '--reverse'
set -gx WASMTIME_HOME "$HOME/.wasmtime"

# Build PATH in the correct order (most specific first)
# Note: We prepend to PATH in reverse priority order
# New path gets searched first (higher priority).
#
# Philosophy: Nix-managed packages take precedence over Homebrew and system packages
# to ensure declarative, reproducible tool versions are used.

# System paths (lowest priority)
set -gx PATH /sbin $PATH
set -gx PATH /usr/sbin $PATH
set -gx PATH /bin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /usr/local/bin $PATH

# Applications
set -gx PATH /Applications/Ghostty.app/Contents/ghostty $PATH
set -gx PATH /Applications/Ghostty.app/Contents/MacOS $PATH
set -gx PATH /Applications/Docker.app/Contents/Resources/bin $PATH

# Homebrew (supplementary packages and GUI apps)
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH /opt/homebrew/bin $PATH

# Development tools (language-specific toolchains)
set -gx PATH $HOME/.local/share/solana/install/active_release/bin $PATH
set -gx PATH $HOME/.foundry/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH

# Nix package manager paths (declarative package management)
# Priority among Nix (lowest to highest):
#   1. System-wide default profile (all users)
#   2. nix-darwin (declarative macOS system config)
#   3. home-manager (declarative user environment)
#   4. User alternative profile location
#   5. User standard profile (imperative user packages)
# These paths have higher priority than Homebrew to ensure reproducible, pinned versions
set -gx PATH /nix/var/nix/profiles/default/bin $PATH  # System-wide default Nix profile
set -gx PATH /run/current-system/sw/bin $PATH  # nix-darwin: declarative macOS system configuration
set -gx PATH /etc/profiles/per-user/$USER/bin $PATH  # home-manager: declarative user packages & dotfiles
set -gx PATH $HOME/.local/share/nix/profile/bin $PATH  # Alternative user profile location
set -gx PATH $HOME/.nix-profile/bin $PATH  # Standard user Nix profile (nix-env installations)

# Local binaries (highest priority - user overrides)
set -gx PATH $HOME/.local/bin $PATH

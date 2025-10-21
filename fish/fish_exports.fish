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

#  Highest Priority
#      ↑
#      └─ ~/.local/bin (user overrides)
#      └─ Nix profiles (reproducible, declarative)
#         ├─ ~/.nix-profile/bin (user imperative packages)
#         ├─ ~/.local/share/nix/profile/bin (alternative location)
#         ├─ /etc/profiles/per-user/$USER/bin (home-manager)
#         ├─ /run/current-system/sw/bin (nix-darwin)
#         └─ /nix/var/nix/profiles/default/bin (system-wide)
#      └─ Dev tools (Cargo, Foundry, Solana)
#      └─ Homebrew (supplementary packages)
#      └─ Applications (Docker, Ghostty)
#      └─ System paths (/usr/bin, /bin, etc.)
#      ↓
#  Lowest Priority
#
#
# Build PATH in the correct order (most specific first)
# Note: Using fish_add_path with --path --move --prepend to manage PATH
# --path: modifies $PATH directly (not $fish_user_paths universal variable)
# --move: repositions existing paths instead of ignoring them
# --prepend: adds to the front of PATH
# This automatically deduplicates and repositions paths correctly.
# We add paths in reverse priority order (lowest first, highest last)
# because --prepend adds to the front of PATH.
#
# Philosophy: Nix-managed packages take precedence over Homebrew and system packages
# to ensure declarative, reproducible tool versions are used.
#
# Note: nix-darwin already sets up Nix paths and Homebrew via /etc/fish/config.fish
# We use --move to reposition them to our desired priority order.

# System paths (lowest priority)
# Note: nix-darwin already adds these, but we ensure they're in the right position
fish_add_path --path --move --prepend /sbin
fish_add_path --path --move --prepend /usr/sbin
fish_add_path --path --move --prepend /bin
fish_add_path --path --move --prepend /usr/bin
fish_add_path --path --move --prepend /usr/local/bin

# Applications
fish_add_path --path --move --prepend /Applications/Ghostty.app/Contents/ghostty
fish_add_path --path --move --prepend /Applications/Ghostty.app/Contents/MacOS
fish_add_path --path --move --prepend /Applications/Docker.app/Contents/Resources/bin

# Homebrew (supplementary packages and GUI apps)
# Note: Homebrew shellenv is sourced by nix-darwin, we reposition for correct priority
fish_add_path --path --move --prepend /opt/homebrew/sbin
fish_add_path --path --move --prepend /opt/homebrew/bin

# Development tools (language-specific toolchains)
fish_add_path --path --move --prepend $HOME/.local/share/solana/install/active_release/bin
fish_add_path --path --move --prepend $HOME/.foundry/bin
fish_add_path --path --move --prepend $HOME/.cargo/bin

# Nix package manager paths (declarative package management)
# Priority among Nix (lowest to highest):
#   1. System-wide default profile (all users)
#   2. nix-darwin (declarative macOS system config)
#   3. home-manager (declarative user environment)
#   4. User alternative profile location
#   5. User standard profile (imperative user packages)
# These paths have higher priority than Homebrew to ensure reproducible, pinned versions
# Note: nix-darwin already adds these, we reposition them for correct priority
fish_add_path --path --move --prepend /nix/var/nix/profiles/default/bin  # System-wide default Nix profile
fish_add_path --path --move --prepend /run/current-system/sw/bin  # nix-darwin: declarative macOS system configuration
fish_add_path --path --move --prepend /etc/profiles/per-user/$USER/bin  # home-manager: declarative user packages & dotfiles
fish_add_path --path --move --prepend $HOME/.local/share/nix/profile/bin  # Alternative user profile location
fish_add_path --path --move --prepend $HOME/.nix-profile/bin  # Standard user Nix profile (nix-env installations)

# Local binaries (highest priority - user overrides)
fish_add_path --path --move --prepend $HOME/.local/bin

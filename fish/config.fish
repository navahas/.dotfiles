#!/usr/bin/env fish
# Main fish configuration file
# This file sources all modular configuration files

# Disable fish greeting
set fish_greeting ""

# Disable autosuggestions
set -U fish_autosuggestion_enabled 0

# Source ---> all fish config files in order of dependencies
set DOTFILES_FISH "$HOME/.dotfiles/fish"

# Source ---> exports (environment variables and PATH)
test -f "$DOTFILES_FISH/fish_exports.fish"; and source "$DOTFILES_FISH/fish_exports.fish"

# Source ---> aliases
test -f "$DOTFILES_FISH/fish_aliases.fish"; and source "$DOTFILES_FISH/fish_aliases.fish"

# Source ---> key bindings
test -f "$DOTFILES_FISH/fish_keybindings.fish"; and source "$DOTFILES_FISH/fish_keybindings.fish"

# Source ---> macOS-specific configuration
test -f "$DOTFILES_FISH/config-osx.fish"; and source "$DOTFILES_FISH/config-osx.fish"

# Ghostty shell integration
if test -n "$GHOSTTY_RESOURCES_DIR"
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

# Source ---> secrets if available
test -f "$HOME/.config/fish/fish_secrets.fish"; and source "$HOME/.config/fish/fish_secrets.fish"

# >> OrbStack integration
source $HOME/.orbstack/shell/init2.fish 2>/dev/null; or true

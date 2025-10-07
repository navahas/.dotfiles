#!/usr/bin/env bash
# Main bash configuration file
# This file sources all modular configuration files

# Source all bash config files
DOTFILES_BASH="$HOME/.dotfiles/bash"

# Source in order of dependencies
[ -f "$DOTFILES_BASH/bash_exports.sh" ] && source "$DOTFILES_BASH/bash_exports.sh"
[ -f "$DOTFILES_BASH/bash_aliases.sh" ] && source "$DOTFILES_BASH/bash_aliases.sh"
[ -f "$DOTFILES_BASH/bash_functions.sh" ] && source "$DOTFILES_BASH/bash_functions.sh"
[ -f "$DOTFILES_BASH/bash_prompt.sh" ] && source "$DOTFILES_BASH/bash_prompt.sh"
[ -f "$DOTFILES_BASH/bash_keybindings.sh" ] && source "$DOTFILES_BASH/bash_keybindings.sh"
[ -f "$DOTFILES_BASH/bash_osx.sh" ] && source "$DOTFILES_BASH/bash_osx.sh"

# Source secrets if available
[ -f "$DOTFILES_BASH/bash_secrets.sh" ] && source "$DOTFILES_BASH/bash_secrets.sh"

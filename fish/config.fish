#!/usr/bin/env fish
# Main fish configuration file
# This file sources all modular configuration files

# Disable fish greeting
set fish_greeting ""

# Disable autosuggestions
set -U fish_autosuggestion_enabled 0
set -x SHELL /sbin/fish

# Key bindings
bind \eu 'clear; date "+%H:%M %d-%m-%Y"'
# bind ctrl-ñ 'nvim .'
bind ctrl-ñ 'tmux-sessionizer-v2-vim; commandline -f repaint'
bind ctrl-N 'tmux-sessionizer-v2-normal; commandline -f repaint'
bind ctrl-S 'tmux-fzf-sessions; commandline -f repaint'
bind ctrl-T 'tmux list-sessions 2>/dev/null | grep -q . && tmux attach || echo "no tmux sessions found"; commandline -f repaint'
bind \cx edit_command_buffer

# Source ---> all fish config files in order of dependencies
set DOTFILES_FISH "$HOME/.dotfiles/fish"

# Source ---> exports (environment variables and PATH)
test -f "$DOTFILES_FISH/fish_exports.fish"; and source "$DOTFILES_FISH/fish_exports.fish"

# Source ---> aliases
test -f "$DOTFILES_FISH/fish_aliases.fish"; and source "$DOTFILES_FISH/fish_aliases.fish"
# Add paths in the correct order
set -gx PATH $HOME/.nvm/versions/node/v22.13.0/bin $PATH
set -gx PATH /Applications/Docker.app/Contents/Resources/bin $PATH
# set -gx PATH /opt/homebrew/bin $PATH
# set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH /Applications/Ghostty.app/Contents/MacOS $PATH
set -gx PATH /Applications/Ghostty.app/Contents/ghostty $PATH
set -gx PATH $HOME/.foundry/bin $PATH
set -gx PATH $HOME/.local/share/solana/install/active_release/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /nix/var/nix/profiles/default/bin $PATH

# Source ---> key bindings
test -f "$DOTFILES_FISH/fish_keybindings.fish"; and source "$DOTFILES_FISH/fish_keybindings.fish"

# Source ---> macOS-specific configuration
test -f "$DOTFILES_FISH/config-osx.fish"; and source "$DOTFILES_FISH/config-osx.fish"

# Aliases
alias vim='nvim'
alias ovim='vim'
alias v.='nvim .'
alias tpv='$HOME/.local/scripts/tmux-sessionizer.sh'
alias tpn='$HOME/.local/scripts/tmux-sessionizer.sh --n'
alias src='source $HOME/.dotfiles/fish/config.fish'
alias dirsync='bash $HOME/.local/scripts/sync-state.sh'
alias dirsync-dev='dirsync -l $HOME/dev/ -r pvps:~/dev/ -e "build/,*.tmp"'
alias neo='neofetch --kitty && $HOME/.local/techstack.sh'
alias tmux-sessionizer-v2-vim='$HOME/.local/scripts/tmux-sessionizer-v2-vim.sh'
alias tmux-sessionizer-v2-normal='$HOME/.local/scripts/tmux-sessionizer-v2-normal.sh'
alias tmux-fzf-sessions='$HOME/.local/scripts/tmux-fzf-sessions.sh'
alias dfzf='$HOME/.local/scripts/docker-fzf-id.sh'
alias ssh-='$HOME/.local/scripts/ssh-fzf.sh'
alias uag='$HOME/.local/scripts/update_aerospace_gap.sh'
#alias ls "ls -p -G --color"
#alias la "ls -Ah --color"
#alias ll "ls -lh --color"
#alias lla "ll -Ah --color"
alias ls "eza -G --color"
alias la "eza -Ah --color"
alias ll "eza -l --color"
alias lla "eza -lA --color"
alias ta="tmux attach"
alias gl="git log --oneline --graph --decorate --all"
alias ghrepo="$HOME/.local/scripts/gh-repo-view.sh"
alias ghrepo-user="$HOME/.local/scripts/gh-user-view.sh"
alias ob="$HOME/.local/scripts/obsidian-tmux-vim.sh"
alias git-treexplorer="$HOME/.local/scripts/git-tree-explorer.sh"
alias nu='nu -c'
alias sh-bm="$HOME/.local/scripts/shell-benchmark.sh"

source (dirname (status --current-filename))/config-osx.fish

# Ghostty shell integration
if test -n "$GHOSTTY_RESOURCES_DIR"
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

# Source ---> secrets if available
test -f "$HOME/.config/fish/fish_secrets.fish"; and source "$HOME/.config/fish/fish_secrets.fish"

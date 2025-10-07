#!/usr/bin/env bash
# Aliases

# Basic editors
alias vim='nvim'
alias ovim='vim'
alias v.='nvim .'

# Tmux sessionizers and utilities
alias tpv="$HOME/.local/scripts/tmux-sessionizer.sh"
alias tpn="$HOME/.local/scripts/tmux-sessionizer.sh --n"
alias ta='tmux attach'
alias tmux-sessionizer-v2-vim="$HOME/.local/scripts/tmux-sessionizer-v2-vim.sh"
alias tmux-sessionizer-v2-normal="$HOME/.local/scripts/tmux-sessionizer-v2-normal.sh"
alias tmux-fzf-sessions="$HOME/.local/scripts/tmux-fzf-sessions.sh"

# Config management
alias src='source ~/.bashrc'

# Directory sync
alias dirsync="bash $HOME/.local/scripts/sync-state.sh"
alias dirsync-dev='dirsync -l $HOME/dev/ -r pvps:~/dev/ -e "build/,*.tmp"'

# System utilities
alias neo="neofetch --kitty && $HOME/.local/techstack.sh"
alias uag="$HOME/.local/scripts/update_aerospace_gap.sh"

# Docker
alias dfzf="$HOME/.local/scripts/docker-fzf-id.sh"

# SSH
alias ssh-="$HOME/.local/scripts/ssh-fzf.sh"

# File listing
alias ls="ls -p -G"
alias la="ls -Ah"
alias ll="eza -l -g --icons"
alias lla="ell -a"

# Git
alias gl="git log --oneline --graph --decorate --all"
alias ghrepo="$HOME/.local/scripts/gh-repo-view.sh"
alias ghrepo-user="$HOME/.local/scripts/gh-user-view.sh"
alias gcm="$HOME/.local/scripts/commit-guidelines.sh"
alias git-treexplorer="$HOME/.local/scripts/git-tree-explorer.sh"

# Other tools
alias ob="$HOME/.local/scripts/obsidian-tmux-vim.sh"
alias nu='nu -c'
alias bash='/usr/local/bin/bash'
alias sh-bm="$HOME/.local/scripts/shell-benchmark.sh"

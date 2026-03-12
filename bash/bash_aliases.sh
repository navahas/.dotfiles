#!/usr/bin/env bash
# Aliases

# Basic editors
alias vim='vim'
alias v.='nvim .'

# Tmux sessionizers and utilities
alias tpv="$HOME/.local/scripts/tmux/tmux-sessionizer-old.sh"
alias tpn="$HOME/.local/scripts/tmux/tmux-sessionizer-old.sh --n"
alias ta='tmux attach'
alias tmux-sessionizer-v2-vim="$HOME/.local/scripts/tmux/tmux-sessionizer-vim.sh"
alias tmux-sessionizer-v2-normal="$HOME/.local/scripts/tmux/tmux-sessionizer-normal.sh"
alias tmux-fzf-sessions="$HOME/.local/scripts/tmux/tmux-fzf-sessions.sh"

alias man="env MANPATH=/Users/navahas/man/share/man man"

# Config management
alias src='source ~/.bashrc'

# Directory sync
alias dirsync="bash $HOME/.local/scripts/system/sync-state.sh"
alias dirsync-dev='dirsync -l $HOME/dev/ -r pvps:~/dev/ -e "build/,*.tmp"'

# System utilities
alias neo="neofetch --kitty && $HOME/.local/techstack.sh"
alias uag="$HOME/.local/scripts/aerospace/update_aerospace_gap.sh"

# Docker
alias dfzf="$HOME/.local/scripts/docker/docker-fzf-id.sh"

# SSH
alias ssh-="$HOME/.local/scripts/ssh/ssh-fzf.sh"

# File listing
alias ls="ls -p -G"
alias la="ls -Ah"
# alias ll="eza -l -g --icons"
# alias lla="ell -a"
LS_COLORS="di=38;5;215:"
LS_COLORS+="ln=4;34:"
LS_COLORS+="or=4;93:"
LS_COLORS+="ex=4;32:"
LS_COLORS+="*.md=3;94:"
LS_COLORS+="*README=3;94:"
LS_COLORS+="*.txt=3:"
LS_COLORS+="*.git=38;5;247:"
LS_COLORS+="*.gitignore=38;5;247:"
LS_COLORS+="*.gitattributes=38;5;247:"
LS_COLORS+="*.gitmodules=38;5;247"
export LS_COLORS

alias lsc="$HOME/.local/scripts/system/lsc.sh"
alias ll="lsc --group-directories-first"
alias lla="lsc -a --group-directories-first"


# Git
alias gl="git log --oneline --graph --decorate --all"
alias ghrepo="$HOME/.local/scripts/dev/gh-repo-view.sh"
alias ghrepo-user="$HOME/.local/scripts/dev/gh-user-view.sh"
alias gcm="$HOME/.local/scripts/git/commit-guidelines.sh"
alias git-treexplorer="$HOME/.local/scripts/git/git-tree-explorer.sh"

# Other tools
alias ob="$HOME/.local/scripts/obsidian/obsidian-tmux-vim.sh"
alias nu='nu -c'
# alias bash='/usr/local/bin/bash'
alias sh-bm="$HOME/.local/scripts/system/shell-benchmark.sh"

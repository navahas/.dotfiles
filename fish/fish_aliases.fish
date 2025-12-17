#!/usr/bin/env fish
# Aliases

# Basic editors
alias vim 'vim'
# alias ovim 'vim'
alias v. 'nvim .'
alias nvim010 'env NVIM_APPNAME=nvim010 command nvim010'

# Tmux sessionizers and utilities
alias tpv '$HOME/.local/scripts/tmux/tmux-sessionizer-old.sh'
alias tpn '$HOME/.local/scripts/tmux/tmux-sessionizer-old.sh --n'
alias ta 'tmux attach'
alias tmux-sessionizer-v2-vim '$HOME/.local/scripts/tmux/tmux-sessionizer-vim.sh'
alias tmux-sessionizer-v2-normal '$HOME/.local/scripts/tmux/tmux-sessionizer-normal.sh'
alias tmux-fzf-sessions '$HOME/.local/scripts/tmux/tmux-fzf-sessions.sh'
alias swapn '$HOME/.local/scripts/tmux/tmux-swap-names.sh'
alias swapmd '$HOME/.local/scripts/tmux/tmux-swap-names.sh main dev'

alias man 'env MANPATH=/Users/navahas/man/share/man man'
alias ctypes '$HOME/.local/scripts/dev/c-scalar-types.nu'

# Config management
alias src 'source $HOME/.dotfiles/fish/config.fish'

# Directory sync
alias dirsync 'bash $HOME/.local/scripts/system/sync-state.sh'
alias dirsync-dev 'dirsync -l $HOME/dev/ -r pvps:~/dev/ -e "build/,*.tmp"'

# System utilities
alias neo 'neofetch --kitty && $HOME/.local/techstack.sh'
alias uag '$HOME/.local/scripts/aerospace/update_aerospace_gap.sh'

# Docker
alias dfzf '$HOME/.local/scripts/docker/docker-fzf-id.sh'

# SSH
alias ssh- '$HOME/.local/scripts/ssh/ssh-fzf.sh'
alias fasts3 'ssh fasts3 -t tmux attach'

# File listing
alias ls "ls -p -G"
alias la "ls -Ah"
# alias ll "eza -l --no-user --icons"
# alias lla "eza -la -io --all --no-user --icons"
# set -Ux LS_COLORS ""

# function ll
#     ls -gFh --color --no-group $argv | sed '/^total/d'
# end
#
# function lla
#     ls -gFh --color --no-group -a $argv | sed '/^total/d'
# end

set -Ux LS_COLORS \
"di=38;5;215:"\
"ln=4;34:"\
"or=4;93:"\
"ex=4;32:"\
"*.md=3;94:"\
"*README=3;94:"\
"*.txt=3;:"\
"*.git=38;5;247:"\
"*.gitignore=38;5;247:"\
"*.gitmodules=38;5;247"

alias lsc "$HOME/.local/scripts/system/lsc.sh"
alias ll "lsc"
alias lla "lsc -a"

# Git
alias gl "git log --oneline --graph --decorate --all"
alias ghrepo "$HOME/.local/scripts/dev/gh-repo-view.sh"
alias ghrepo-user "$HOME/.local/scripts/dev/gh-user-view.sh"
alias gcm "$HOME/.local/scripts/git/commit-guidelines.sh"
alias git-treexplorer "$HOME/.local/scripts/git/git-tree-explorer.sh"

# Other tools
alias ob "$HOME/.local/scripts/obsidian/obsidian-tmux-vim.sh"
alias nu 'nu -c'
# alias bash '/usr/local/bin/bash'
alias sh-bm "$HOME/.local/scripts/system/shell-benchmark.sh"

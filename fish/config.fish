set fish_greeting ""
set -x SHELL /opt/homebrew/bin/fish

# Key bindings
bind \eu 'clear; date "+%H:%M %d-%m-%Y"'
bind ctrl-ñ 'nvim .'
bind ctrl-V 'tmux-sessionizer-v2-vim; commandline -f repaint'
bind ctrl-N 'tmux-sessionizer-v2-normal; commandline -f repaint'
bind ctrl-S 'tmux-fzf-sessions; commandline -f repaint'
bind ctrl-T 'tmux list-sessions 2>/dev/null | grep -q . && tmux attach || echo "no tmux sessions found"; commandline -f repaint'
bind \cx edit_command_buffer

# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx NVM_DIR $HOME/.nvm

# Clear existing PATH
set -gx PATH

# Add paths in the correct order
set -gx PATH $HOME/.nvm/versions/node/v22.13.0/bin $PATH
set -gx PATH /Applications/Docker.app/Contents/Resources/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH /Applications/Ghostty.app/Contents/MacOS $PATH
set -gx PATH /Applications/Ghostty.app/Contents/ghostty $PATH
set -gx PATH $HOME/.foundry/bin $PATH
set -gx PATH $HOME/.local/share/solana/install/active_release/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

# System paths (should already be included, but just in case)
set -gx PATH /usr/local/bin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /bin $PATH
set -gx PATH /usr/sbin $PATH
set -gx PATH /sbin $PATH

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
alias ls "ls -p -G"
alias la "ls -Ah"
alias ll "ls -lh"
alias lla "ll -Ah"
alias ta="tmux attach"
alias gl="git log --oneline --graph --decorate --all"
alias ghrepo="$HOME/.local/scripts/gh-repo-view.sh"
alias ghrepo-user="$HOME/.local/scripts/gh-user-view.sh"
alias obs="$HOME/.local/scripts/obsidian-tmux-vim.sh"
alias git-treexplorer="$HOME/.local/scripts/git-tree-explorer.sh"

source (dirname (status --current-filename))/config-osx.fish

if test -n "$GHOSTTY_RESOURCES_DIR"
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

# Secrets
source "$HOME/.config/fish/fish_secrets.fish"

export BAT_THEME="Visual Studio Dark+"
export FZF_DEFAULT_OPTS='--reverse'

set -gx WASMTIME_HOME "$HOME/.wasmtime"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source $HOME/.orbstack/shell/init2.fish 2>/dev/null || :

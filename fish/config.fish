set fish_greeting ""
# set -x SHELL /usr/local/bin/fish

# Key bindings
bind \eu 'clear; date "+%H:%M %d-%m-%Y"'
bind ctrl-ñ 'nvim .'
bind ctrl-V 'tmux-sessionizer-v2-vim; commandline -f repaint'
bind ctrl-N 'tmux-sessionizer-v2-normal; commandline -f repaint'
bind ctrl-S 'tmux-fzf-sessions; commandline -f repaint'
bind ctrl-T 'tmux list-sessions 2>/dev/null | grep -q . && tmux attach || echo "no tmux sessions found"; commandline -f repaint'
bind \cx edit_command_buffer

set -U fish_autosuggestion_enabled 0

# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx NVM_DIR $HOME/.nvm
set -gx EZA_CONFIG_DIR $HOME/.config/eza

# Clear existing PATH
set -gx PATH

# Nix stuff
set -gx PATH $HOME/.nix-profile/bin $PATH
set -gx PATH $HOME/.local/share/nix/profile/bin $PATH
set -gx PATH /nix/var/nix/profiles/default/bin $PATH
# (after you enable nix-darwin, this one may exist too)
set -gx PATH /run/current-system/sw/bin $PATH

# Add paths in the correct order (most specific first)
# Local binaries
set -gx PATH $HOME/.local/bin $PATH

# Development tools
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.foundry/bin $PATH
set -gx PATH $HOME/.local/share/solana/install/active_release/bin $PATH

# Homebrew
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH

# Applications
set -gx PATH /Applications/Docker.app/Contents/Resources/bin $PATH
set -gx PATH /Applications/Ghostty.app/Contents/MacOS $PATH
set -gx PATH /Applications/Ghostty.app/Contents/ghostty $PATH

# Package managers
set -gx PATH /nix/var/nix/profiles/default/bin $PATH

# System paths
set -gx PATH /usr/local/bin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /bin $PATH
set -gx PATH /usr/sbin $PATH
set -gx PATH /sbin $PATH

# Aliases
alias vim 'nvim'
alias ovim 'vim'
alias v. 'nvim .'
alias tpv '$HOME/.local/scripts/tmux/tmux-sessionizer-old.sh'
alias tpn '$HOME/.local/scripts/tmux/tmux-sessionizer-old.sh --n'
alias src 'source $HOME/.dotfiles/fish/config.fish'
alias dirsync 'bash $HOME/.local/scripts/system/sync-state.sh'
alias dirsync-dev 'dirsync -l $HOME/dev/ -r pvps:~/dev/ -e "build/,*.tmp"'
alias neo 'neofetch --kitty && $HOME/.local/techstack.sh'
alias tmux-sessionizer-v2-vim '$HOME/.local/scripts/tmux/tmux-sessionizer-vim.sh'
alias tmux-sessionizer-v2-normal '$HOME/.local/scripts/tmux/tmux-sessionizer-normal.sh'
alias tmux-fzf-sessions '$HOME/.local/scripts/tmux/tmux-fzf-sessions.sh'
alias dfzf '$HOME/.local/scripts/docker/docker-fzf-id.sh'
alias ssh- '$HOME/.local/scripts/ssh/ssh-fzf.sh'
alias uag '$HOME/.local/scripts/aerospace/update_aerospace_gap.sh'
alias ls "ls -p -G"
alias la "ls -Ah"
#alias ll "ls -lh"
#alias lla "ll -Ah"
alias ll "eza -l -g --icons"
alias lla "ell -a"
alias ta "tmux attach"
alias gl "git log --oneline --graph --decorate --all"
alias ghrepo "$HOME/.local/scripts/dev/gh-repo-view.sh"
alias ghrepo-user "$HOME/.local/scripts/dev/gh-user-view.sh"
alias gcm "$HOME/.local/scripts/git/commit-guidelines.sh"
alias ob "$HOME/.local/scripts/obsidian/obsidian-tmux-vim.sh"
alias git-treexplorer "$HOME/.local/scripts/git/git-tree-explorer.sh"
alias nu 'nu -c'
#alias bash '/usr/local/bin/bash'
alias sh-bm "$HOME/.local/scripts/system/shell-benchmark.sh"

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

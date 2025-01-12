set fish_greeting ""
set -x SHELL /opt/homebrew/bin/fish

# Key bindings
bind \eu 'clear; date "+%H:%M %d-%m-%Y"'
bind \en 'nvim .'
bind \e\[118\;6u 'tmux-sessionizer-v2-vim'
bind \e\[110\;6u 'tmux-sessionizer-v2-normal'
bind \cx edit_command_buffer

# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx NVM_DIR $HOME/.nvm

# Clear existing PATH
set -gx PATH

# Add paths in the correct order
set -gx PATH /Users/usuario00/.nvm/versions/node/v20.14.0/bin $PATH
set -gx PATH /Applications/Docker.app/Contents/Resources/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH /Users/usuario00/.cargo/bin $PATH
set -gx PATH /Applications/Ghostty.app/Contents/MacOS $PATH
set -gx PATH /Applications/Ghostty.app/Contents/ghostty $PATH
set -gx PATH /Users/usuario00/.foundry/bin $PATH

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
alias tpv='~/.local/scripts/tmux-sessionizer.sh'
alias tpn='~/.local/scripts/tmux-sessionizer.sh --n'
alias src='source ~/.dotfiles/fish/config.fish'
alias dirsync='bash ~/.local/scripts/sync-state.sh'
alias dirsync-dev='dirsync -l ~/dev/ -r pvps:~/dev/ -e "build/,*.tmp"'
alias neo='neofetch --kitty && ~/.local/techstack.sh'
alias tmux-sessionizer-v2-vim='~/.local/scripts/tmux-sessionizer-v2-vim.sh'
alias tmux-sessionizer-v2-normal='~/.local/scripts/tmux-sessionizer-v2-normal.sh'
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias fcd='cd "$(fzf)"'
alias fman="compgen -c | fzf | xargs man"
alias ta="tmux attach"

source (dirname (status --current-filename))/config-osx.fish

if test -n "$GHOSTTY_RESOURCES_DIR"
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

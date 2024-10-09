# eNable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey -e

export EDITOR="nvim"
export VISUAL="nvim"

alias vim="nvim"
alias ovim="vim"

# Add PATHS
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.docker/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm_completion

source <(fzf --zsh)
# Enable the "new" completion system (compsys).
autoload -Uz compinit
compinit

# Load plugins from Homebrew's installation directory.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_STYLES[arg0]='fg=white'
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=011'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=11'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
ZSH_HIGHLIGHT_STYLES[path]='none'

# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=173'
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=173'
# ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

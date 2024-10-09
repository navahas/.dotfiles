# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source common Zsh config
source ~/.zshrc_common

# Load platform-specific settings
if [[ "$(uname)" == "Darwin" ]]; then
  source ~/.zshrc_mac
elif [[ "$(uname)" == "Linux" ]]; then
  source ~/.zshrc_linux
fi

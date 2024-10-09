# Source common Zsh config
source ~/.zshrc_common

# Load platform-specific settings
if [[ "$(uname)" == "Darwin" ]]; then
  source ~/.zshrc_mac
elif [[ "$(uname)" == "Linux" ]]; then
  source ~/.zshrc_linux
fi

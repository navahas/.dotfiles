#!/bin/bash

# Update package list and upgrade system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y zsh tmux neovim git curl

# Install Powerlevel10k, Syntax Highlighting, and Autosuggestions for Zsh
mkdir -p ~/.config/zsh/plugins

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/plugins/powerlevel10k

# Zsh Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions

# Change default shell to Zsh
chsh -s $(which zsh)

echo "Installation complete. Restart the terminal or run 'zsh' to start using Zsh."


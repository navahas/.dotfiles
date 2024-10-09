#!/bin/bash

# Directories and files
DOTFILES_DIR="$HOME/.dotfiles"
ZSH_COMMON="$DOTFILES_DIR/zsh/.zshrc_common"
ZSH_MAC="$DOTFILES_DIR/zsh/.zshrc_mac"
ZSH_LINUX="$DOTFILES_DIR/zsh/.zshrc_linux"
ZSH_TARGET="$HOME/.zshrc"

# Detect OS and set platform-specific Zsh config
if [[ "$(uname)" == "Darwin" ]]; then
    OS="macOS"
    PLATFORM_SPECIFIC="$ZSH_MAC"
elif [[ "$(uname)" == "Linux" ]]; then
    OS="Linux"
    PLATFORM_SPECIFIC="$ZSH_LINUX"
else
    echo "Unsupported operating system."
    exit 1
fi

echo "Detected $OS. Setting up .zshrc..."

# Create a backup of existing .zshrc if it exists
if [ -f "$ZSH_TARGET" ]; then
    echo "Backing up existing .zshrc to .zshrc.backup"
    mv "$ZSH_TARGET" "$ZSH_TARGET.backup"
fi

# Merge common and platform-specific configs into .zshrc
cat "$ZSH_COMMON" > "$ZSH_TARGET"
echo "" >> "$ZSH_TARGET"
cat "$PLATFORM_SPECIFIC" >> "$ZSH_TARGET"

echo ".zshrc setup complete!"

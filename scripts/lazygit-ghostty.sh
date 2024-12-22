#!/bin/bash

is_nvim_running() {
  pgrep -x nvim > /dev/null
}

if is_nvim_running; then
  read -p "Neovim is running. Do you want to open lazygit? (yes/no): " choice
  case "$choice" in
    yes|y|Y)
      lazygit
      ;;
    no|n|N)
      echo "Skipping lazygit."
      ;;
    *)
      echo "Invalid input. Exiting."
      ;;
  esac
else
  echo "Neovim is not running."
fi

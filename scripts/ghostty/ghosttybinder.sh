#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/ghostty/config"
BACKUP_FILE="$CONFIG_FILE.bak"

# Trap to restore the config on script exit
trap restore_original_config EXIT

is_nvim_running() {
  pgrep -x nvim > /dev/null
}

update_keybind_for_nvim() {
  sed -i.bak -e '/^keybind = super+ctrl+l=goto_split:right/c\
keybind = ctrl+l=goto_split:right' "$CONFIG_FILE"
  echo "Updated keybinding to ctrl+l for Neovim session."
}

restore_original_config() {
  sed -i.bak -e '/^keybind = ctrl+l=goto_split:right/c\
keybind = super+ctrl+l=goto_split:right' "$CONFIG_FILE"
  echo "Restored keybinding to super+ctrl+l."
}

if [ ! -f "$BACKUP_FILE" ]; then
  cp "$CONFIG_FILE" "$BACKUP_FILE"
  echo "Backup of the original config file created at $BACKUP_FILE."
fi

while true; do
  if is_nvim_running; then
    # Check if the keybind needs to be updated
    if grep -q "^keybind = super+ctrl+l=goto_split:right" "$CONFIG_FILE"; then
      update_keybind_for_nvim
    fi
  else
    # Restore the keybind if not in Neovim
    if grep -q "^keybind = ctrl+l=goto_split:right" "$CONFIG_FILE"; then
      restore_original_config
    fi
  fi
  sleep 2
done

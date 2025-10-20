#!/usr/bin/env bash

CONFIG_FILE=$HOME/.config/ghostty/config

cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

AVAILABLE_THEMES=$(ghostty +list-themes | sed 's/ (resources)//g')

if [ $? -ne 0 ]; then
  echo "Failed to retrieve themes. Is Ghostty running and properly installed?"
  exit 1
fi

RANDOM_THEME=$(echo "$AVAILABLE_THEMES" | awk 'BEGIN{srand()} {themes[NR] = $0} END{print themes[int(rand() * NR) + 1]}')

# Update the theme in the config file
if grep -q "^theme = " "$CONFIG_FILE"; then
  sed -i.bak "s/^theme = .*/theme = $RANDOM_THEME/" "$CONFIG_FILE"
else
  echo "theme = $RANDOM_THEME" >> "$CONFIG_FILE"
fi

# echo "Applied random theme: $RANDOM_THEME"

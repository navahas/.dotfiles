#!/usr/bin/env bash
search_dirs=("$HOME/.dotfiles" "$HOME/.config" "$HOME/.ssh" "$HOME/.local" "$HOME/dev")

selected_dir=$( { \
    for dir in "${search_dirs[@]}"; do
        if [ -d "$dir" ]; then
            # List immediate directories in each search dir
            ls -d "$dir"/*/ 2>/dev/null
            # For dev directory, also list one level deeper
            if [[ "$dir" == "$HOME/dev" ]]; then
                ls -d "$dir"/*/*/ 2>/dev/null
            fi
        fi
    done; \
    # Add home directory files/folders but exclude . and ..
    ls -d ~/* ~/.* 2>/dev/null | grep -v "^\.$\|^\.\.$"; \
} | grep -v "/\.\|/node_modules\|/build\|/dist\|/target\|/\.next" | fzf)

if [[ -n $selected_dir && -d $selected_dir ]]; then
    echo "$selected_dir"
fi

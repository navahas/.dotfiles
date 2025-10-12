#!/usr/bin/env bash

# Directory navigation script with fzf integration
# Searches through common development and config directories

# Define search directories array
readonly search_dirs=(
    "$HOME/.dotfiles"
    "$HOME/.config"
    "$HOME/.ssh"
    "$HOME/.local"
    "$HOME/dev"
)

# Main directory selection logic
main() {
    local selected_dir
    
    selected_dir=$( { \
        # Iterate through each search directory
        for dir in "${search_dirs[@]}"; do
            if [[ -d "$dir" ]]; then
                # List immediate directories in each search dir
                ls -d "$dir"/*/ 2>/dev/null
                
                # For dev directory, also list one level deeper for projects
                if [[ "$dir" == "$HOME/dev" ]]; then
                    ls -d "$dir"/*/*/ 2>/dev/null
                fi
            fi
        done
        
        # Add home directory files/folders but exclude . and ..
        ls -d ~/* ~/.* 2>/dev/null | grep -v "^\.$\|^\.\.$"
    } | \
    # Filter out common directories to ignore
    grep -v "/\.\|/node_modules\|/build\|/dist\|/target\|/\.next" | \
    # Use fzf for interactive selection with custom colors
    fzf --color=fg:#e7e7d3,hl:#c67c67 \
        --color=fg+:#e7e7d3,bg+:#2a2a2a,hl+:#c67c67 \
        --color=info:#8ab4b6,prompt:#B9D29D,pointer:#c67c67 \
        --color=marker:#c67c67,spinner:#8ab4b6,header:#8ab4b6 \
        --prompt="[> " \
    )
    
    # Validate selection and output result
    if [[ -n "$selected_dir" && -d "$selected_dir" ]]; then
        echo "$selected_dir"
        return 0
    else
        return 1
    fi
}

main "$@"

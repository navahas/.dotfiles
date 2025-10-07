#!/usr/bin/env bash
# Bash prompt configuration with git support

# Colors
COLOR_BLUE='\[\e[34m\]'
COLOR_GREEN='\[\e[32m\]'
COLOR_RED='\[\e[31m\]'
COLOR_GREY='\[\e[38;5;244m\]'
COLOR_RESET='\[\e[0m\]'

# Function to get git branch and dirty status
__git_prompt() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch=$(git branch --show-current 2>/dev/null)
        local dirty=""

        # Check if there are any changes
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            dirty="*"
        fi

        echo "${COLOR_GREY}${branch}${dirty} ${COLOR_RESET}"
    fi
}

# Function to show last exit status
__status_prompt() {
    local status=$1
    if [ $status -ne 0 ]; then
        echo "${COLOR_RED}[$status]  ${COLOR_RESET}"
    else
        echo "${COLOR_GREEN}  ${COLOR_RESET}"
    fi
}

# Set the prompt
# This uses PROMPT_COMMAND to dynamically update the prompt
__build_prompt() {
    local last_status=$?

    # Current directory (replace $HOME with ~)
    local current_dir="$PWD"
    if [[ "$PWD" == "$HOME"* ]]; then
        current_dir="~${PWD#$HOME}"
    fi

    # Build prompt components
    local dir_part="${COLOR_BLUE}${current_dir}${COLOR_RESET}"
    local git_part="$(__git_prompt)"
    local status_part="$(__status_prompt $last_status)"

    PS1=" ${dir_part} ${git_part}${status_part}"
}

# Use PROMPT_COMMAND to set prompt dynamically
PROMPT_COMMAND=__build_prompt

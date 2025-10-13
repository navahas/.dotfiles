#!/usr/bin/env bash
# Minimal dotfile linker / unlinker using a JSON config.
# Usage:
#   ./dotlink.sh [link|unlink] [--dry-run]
# Default action = link

# set -e: exit on error
# set -u: exit on undefined variable
# set -o pipefail: exit on pipe failure (not just last command)
set -euo pipefail

# Get absolute path to script directory, even if called via symlink
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/links.json"

# ${1:-link} means: use $1 if set, otherwise default to "link"
ACTION="${1:-link}"
DRY_RUN="${2:-}"

# Sanity checks: make sure we have jq installed and config file exists
command -v jq >/dev/null 2>&1 || { echo "jq not found"; exit 1; }
[ -f "$CONFIG_FILE" ] || { echo "$CONFIG_FILE missing"; exit 1; }

# run: helper function to either execute or print commands
# Used for --dry-run mode to preview what would happen without making changes
run() {
    if [ "$DRY_RUN" = "--dry-run" ]; then
        echo "[dry-run] $*"
    else
        # eval is needed here because $@ contains quoted strings that need re-evaluation
        eval "$@"
    fi
}

# Parse JSON config with jq:
# - '.links' gets the links object
# - 'to_entries[]' converts {key: value} to [{key: "key", value: "value"}]
# - Output format: "target=source" (one per line)
# The -r flag outputs raw strings without JSON quotes
jq -r '.links | to_entries[] | "\(.key)=\(.value)"' "$CONFIG_FILE" |
    while IFS='=' read -r target source; do
        # IFS='=' splits each line on '=' into target and source variables
        # -r flag prevents backslash interpretation in strings

        # Expand ~ to actual home directory (bash parameter expansion)
        # ${var/#pattern/replacement} replaces pattern at start of var
        target="${target/#\~/$HOME}"
        source="$SCRIPT_DIR/$source"

        # Skip if source doesn't exist (broken config)
        [ -e "$source" ] || { echo "skip missing source: $source"; continue; }

        case "$ACTION" in
            link)
                # Create parent directories first (e.g., ~/.config for ~/.config/nvim)
                # -p flag: no error if exists, make parent dirs as needed
                mkdir -p "$(dirname "$target")"

                # Check what exists at target location:
                # -L: true if symbolic link
                # -f: true if regular file
                # -d: true if directory
                if [ -L "$target" ] || [ -f "$target" ]; then
                    # Remove existing symlink or file
                    # We use rm -f (force) to suppress errors if it doesn't exist
                    # We handle removal separately from ln to have explicit control
                    # (ln -sf would overwrite but we want to handle edge cases)
                    run "rm -f \"$target\""
                elif [ -d "$target" ]; then
                    # Don't remove directories - too dangerous
                    # User should manually handle directory conflicts
                    echo "skip dir: $target"
                    continue
                fi

                # Create the symlink
                # We use ln -s (not -sf) because we already handled removal above
                # This way we get an error if something went wrong with our logic
                # -s: make symbolic (not hard) link
                run "ln -s \"$source\" \"$target\""
                echo "link: $target -> $source"
                ;;
            unlink)
                # Only remove if it's a symlink (safety check)
                # We don't use -f here so we get feedback if something's wrong
                if [ -L "$target" ]; then
                    run "rm \"$target\""
                    echo "unlink: $target"
                else
                    echo "skip: $target"
                fi
                ;;
            *)
                echo "usage: $0 [link|unlink] [--dry-run]"
                exit 1
                ;;
        esac
    done

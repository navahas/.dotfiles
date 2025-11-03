#!/usr/bin/env bash
set -euo pipefail

name1=${1:-}
name2=${2:-}

if [[ -z "$name1" || -z "$name2" ]]; then
    echo "Usage: swapn <name1> <name2>" >&2
    exit 1
fi

tmux rename-window -t "$name1" _t_
tmux rename-window -t "$name2" "$name1"
tmux rename-window -t _t_ "$name2"

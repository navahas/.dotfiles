#!/usr/bin/env bash
aerospace_file="$HOME/.dotfiles/aerospace/aerospace.toml"

if [[ "$(whoami)" != "cnavajas" ]]; then
    sed -i '' '37i\
[gaps]\
inner.horizontal = 11\
inner.vertical = 11\
outer.left = 11\
outer.bottom = 11\
outer.top = 11\
outer.right = 11\
\
' "$aerospace_file"
else
    sed -i '' '37i\
[gaps]\
inner.horizontal = 24\
inner.vertical = 24\
outer.left = 24\
outer.bottom = 24\
outer.top = 24\
outer.right = 24\
\
' "$aerospace_file"
fi
exit 0

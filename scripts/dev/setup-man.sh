#!/usr/bin/env bash

set -e

MAN_DIR="$HOME/man"
REPO_URL="https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git"

echo "Setting up local Linux man-pages from $REPO_URL"
echo "- Target directory: $MAN_DIR"
echo ""

# fetch or update repo
if [ -d "$MAN_DIR/repo/.git" ]; then
  echo "Updating existing man-pages repo..."
  git -C "$MAN_DIR/repo" pull --quiet
else
  echo "Cloning man-pages repo..."
  mkdir -p "$MAN_DIR"
  git clone --depth=1 "$REPO_URL" "$MAN_DIR/repo" --quiet
fi

echo "Organizing man pages..."
mkdir -p "$MAN_DIR/share/man"
find "$MAN_DIR/repo" -type f -name '*.[0-9]*' | while read -r f; do
  sec="${f##*.}"
  dest="$MAN_DIR/share/man/man$sec"
  mkdir -p "$dest"
  cp -n "$f" "$dest/" 2>/dev/null || true
done

echo "For Fish:"
echo "set -gx MANPATH $HOME/man/share/man \$MANPATH"
echo "alias man 'env MANPATH=$HOME/man/share/man man'"
echo
echo "For Bash/Zsh:"
echo "export MANPATH=\$HOME/man/share/man:\$MANPATH"
echo "alias man='MANPATH=\$HOME/man/share/man man'"

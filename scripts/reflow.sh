#!/usr/bin/env bash

function csi() {
  echo -ne "\033[$1"
}

COLS=$(tput cols)

# Clear the screen
csi "2J"
csi "H"

# Write enough text to put our cursor in the pending wrap position "A"
for i in $(seq 1 $((COLS))); do
  echo -n "O"
done
for i in $(seq 1 $((COLS - 1))); do
  echo -n "O"
done
echo -n "A"

# Save the cursor
echo -ne "\x1b7"

# Move the cursor to the top-left
csi "H"

# Maximize the window at this point then press enter
read

# Restore the cursor
echo -ne "\x1b8"
echo -ne "X"

read

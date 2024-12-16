#!/bin/bash

# Default Configuration
EXCLUDE_PATTERNS=("node_modules/" "*.log" ".git/" ".DS_Store")  # Excluded patterns
TIMESTAMP_FILE=".sync_timestamp"                               # Tracking file name

# Function to display usage
usage() {
  echo "Usage: $0 [-l LOCAL_ROOT] [-r REMOTE] [-e EXCLUDES]"
  echo "  -l LOCAL_ROOT   Local directory to sync"
  echo "  -r REMOTE       Remote directory in 'host:path' format"
  echo "  -e EXCLUDES     Additional patterns to exclude (comma-separated)"
  exit 1
}

# Parse options
while getopts "l:r:e:h" opt; do
  case $opt in
    l) LOCAL_ROOT="$OPTARG" ;;
    r) REMOTE="$OPTARG" ;;
    e) IFS=',' read -r -a ADDITIONAL_EXCLUDES <<< "$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done

# Ensure required arguments are provided
if [ -z "$LOCAL_ROOT" ] || [ -z "$REMOTE" ]; then
  echo "Error: Both LOCAL_ROOT and REMOTE must be provided."
  usage
fi

# Merge exclude patterns
EXCLUDE_ARGS=""
for pattern in "${EXCLUDE_PATTERNS[@]}" "${ADDITIONAL_EXCLUDES[@]}"; do
  EXCLUDE_ARGS+="--exclude=$pattern "
done

# Update local timestamp file
update_local_timestamp() {
  echo "$(date +%s)" > "${LOCAL_ROOT}${TIMESTAMP_FILE}"
}

# Fetch remote timestamp
fetch_remote_timestamp() {
  local tmpfile=$(mktemp)
  rsync -az "${REMOTE}${TIMESTAMP_FILE}" "$tmpfile" 2>/dev/null
  if [ $? -eq 0 ]; then
    cat "$tmpfile"
  else
    echo "0"  # Default to 0 if remote timestamp is missing
  fi
  rm -f "$tmpfile"
}

# Sync logic
sync_directories() {
  local local_timestamp
  local remote_timestamp

  # Ensure local timestamp file exists
  if [ ! -f "${LOCAL_ROOT}${TIMESTAMP_FILE}" ]; then
    echo "Local timestamp missing. Creating it..."
    update_local_timestamp
  fi

  local_timestamp=$(cat "${LOCAL_ROOT}${TIMESTAMP_FILE}")
  remote_timestamp=$(fetch_remote_timestamp)

  echo "Local timestamp: $local_timestamp"
  echo "Remote timestamp: $remote_timestamp"

  if [ "$local_timestamp" -gt "$remote_timestamp" ]; then
    echo "Local is newer or first sync. Uploading to remote..."
    rsync -az --delete $EXCLUDE_ARGS "$LOCAL_ROOT" "$REMOTE"
    update_local_timestamp
  elif [ "$local_timestamp" -lt "$remote_timestamp" ]; then
    echo "Remote is newer. Downloading to local..."
    rsync -az --delete $EXCLUDE_ARGS "$REMOTE" "$LOCAL_ROOT"
    update_local_timestamp
  else
    echo "Local and remote are already in sync."
  fi
}

# Run the sync
sync_directories

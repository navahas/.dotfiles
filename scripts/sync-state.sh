#!/bin/bash

# Default Configuration
EXCLUDE_PATTERNS=("node_modules/" "*.log" ".DS_Store")
TIMESTAMP_FILE=".sync_timestamp"
LOG_FILE="$HOME/.sync.log"

# Utility: Log messages
log() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

# Utility: Generate exclude arguments for rsync
build_exclude_args() {
  local exclude_args=""
  for pattern in "${EXCLUDE_PATTERNS[@]}" "${ADDITIONAL_EXCLUDES[@]}"; do
    exclude_args+="--exclude=$pattern "
  done
  echo "$exclude_args"
}

# Utility: Ensure the local timestamp file exists
ensure_local_timestamp() {
  if [ ! -f "${LOCAL_ROOT}${TIMESTAMP_FILE}" ]; then
    log "Local timestamp missing. Creating it..."
    date '+%s' > "${LOCAL_ROOT}${TIMESTAMP_FILE}"
  fi
}

# Fetch the remote timestamp
fetch_remote_timestamp() {
  local tmpfile=$(mktemp)
  rsync -az "${REMOTE}${TIMESTAMP_FILE}" "$tmpfile" 2>/dev/null
  if [ $? -eq 0 ]; then
    cat "$tmpfile"
  else
    echo "0"
  fi
  rm -f "$tmpfile"
}

# Convert Unix timestamp to human-readable format
human_readable_timestamp() {
  local timestamp="$1"
  if [ "$timestamp" -gt 0 ]; then
    date -r "$timestamp" '+%Y-%m-%d %H:%M:%S'
  else
    echo "No timestamp available"
  fi
}

# Perform upload to remote
upload_to_remote() {
  log "Local is newer. Uploading changes to remote..."
  rsync -avz --delete $(build_exclude_args) "$LOCAL_ROOT" "$REMOTE" | tee -a "$LOG_FILE"
  date '+%s' > "${LOCAL_ROOT}${TIMESTAMP_FILE}"
}

# Perform download from remote
download_from_remote() {
  log "Remote is newer. Downloading changes to local..."
  rsync -avz --delete $(build_exclude_args) "$REMOTE" "$LOCAL_ROOT" | tee -a "$LOG_FILE"
  date '+%s' > "${LOCAL_ROOT}${TIMESTAMP_FILE}"
}

# Main Sync Logic
sync_directories() {
  ensure_local_timestamp
  local local_timestamp=$(cat "${LOCAL_ROOT}${TIMESTAMP_FILE}")
  local remote_timestamp=$(fetch_remote_timestamp)

  log "Local timestamp: $(human_readable_timestamp "$local_timestamp")"
  log "Remote timestamp: $(human_readable_timestamp "$remote_timestamp")"

  if [ "$local_timestamp" -gt "$remote_timestamp" ]; then
    upload_to_remote
  elif [ "$local_timestamp" -lt "$remote_timestamp" ]; then
    download_from_remote
  else
    log "Local and remote are already in sync."
  fi
}

# Parse arguments
while getopts "l:r:e:h" opt; do
  case $opt in
    l) LOCAL_ROOT="$OPTARG" ;;
    r) REMOTE="$OPTARG" ;;
    e) IFS=',' read -r -a ADDITIONAL_EXCLUDES <<< "$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done

if [ -z "$LOCAL_ROOT" ] || [ -z "$REMOTE" ]; then
  echo "Error: Both LOCAL_ROOT and REMOTE must be provided."
  usage
fi

# Run the sync
sync_directories

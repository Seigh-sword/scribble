#!/bin/bash

# Scribble Launcher + Auto-Updater
# Automatically checks GitHub for updates daily
# Place in ~/.scribble/bin/scribble or C:\Scribble\bin\scribble

INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LAST_UPDATE_FILE="$INSTALL_DIR/.last-update"
UPDATE_INTERVAL=86400  # 24 hours in seconds

check_and_update() {
    local now=$(date +%s)
    local last_update=0
    
    # Get last update time
    if [ -f "$LAST_UPDATE_FILE" ]; then
        last_update=$(cat "$LAST_UPDATE_FILE")
    fi
    
    # Check if we need to update (24 hour cooldown)
    if [ $((now - last_update)) -gt $UPDATE_INTERVAL ]; then
        echo "[Scribble] Checking for updates..." >&2
        
        # Determine OS
        OS="$(uname -s)"
        case "${OS}" in
            Linux*)     ASSET="scribble-linux.tar.gz";;
            Darwin*)    ASSET="scribble-mac.tar.gz";;
            *)          ASSET="";;
        esac

        if [ ! -z "$ASSET" ]; then
             # Download and extract to install dir
             if curl -L -s "https://github.com/Seigh-sword/scribble/releases/latest/download/$ASSET" -o /tmp/scribble_update.tar.gz; then
                 tar -xzf /tmp/scribble_update.tar.gz -C "$INSTALL_DIR"
                 rm /tmp/scribble_update.tar.gz
                 echo "[Scribble] Updated to latest version." >&2
             fi
        fi

        # Update timestamp
        echo "$now" > "$LAST_UPDATE_FILE"
    fi
}

# Run auto-update check in background
check_and_update &

# Execute ses command
cd "$INSTALL_DIR"
exec ./ses "$@"

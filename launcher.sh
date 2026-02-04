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
        # Binary update logic would go here (downloading new tarball)
        # For now, we skip git-based updates
        # Update timestamp
        echo "$now" > "$LAST_UPDATE_FILE"
    fi
}

# Run auto-update check in background
check_and_update &

# Execute ses command
cd "$INSTALL_DIR"
exec ./ses "$@"

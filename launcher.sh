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
        echo "[SES] Checking for updates..." >&2
        cd "$INSTALL_DIR"
        
        # Fetch latest from GitHub
        if git fetch origin main > /dev/null 2>&1; then
            # Check if there are changes
            if ! git diff --quiet origin/main; then
                echo "[SES] Updates found! Installing..." >&2
                git pull origin main > /dev/null 2>&1
                
                # Rebuild
                if [ -f "CMakeLists.txt" ]; then
                    cmake -S . -B build -DBUILD_SHARED_LIBS=ON > /dev/null 2>&1
                    cmake --build build -j$(nproc) > /dev/null 2>&1
                    echo "[SES] ✓ Updated and rebuilt" >&2
                fi
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

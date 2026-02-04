#!/bin/bash

# Scribble Auto-Installer
# Download, setup, and auto-update system
# Users: Just run this once, then use 'scribble' anywhere!

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_URL="https://github.com/Seigh-sword/scribble.git"
INSTALL_DIR="${HOME}/.scribble"
BIN_DIR="${INSTALL_DIR}/bin"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Scribble Auto-Installer             ║${NC}"
echo -e "${BLUE}║  One-click setup & auto-updates      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check requirements
echo -e "${YELLOW}Checking requirements...${NC}"
if ! command -v curl &> /dev/null; then
    echo -e "${RED}✗ curl not found. Please install it.${NC}"
    exit 1
fi
echo ""

# Download/update repo
echo -e "${YELLOW}Setting up Scribble...${NC}"
mkdir -p "$INSTALL_DIR"

# Detect OS for download
OS="$(uname -s)"
case "${OS}" in
    Linux*)     ASSET="scribble-linux.tar.gz";;
    Darwin*)    ASSET="scribble-mac.tar.gz";;
    *)          echo "Unsupported OS"; exit 1;;
esac

echo -e "  Downloading compiled binaries..."
cd "$INSTALL_DIR"
curl -L "https://github.com/Seigh-sword/scribble/releases/latest/download/$ASSET" -o scribble.tar.gz

echo -e "  Extracting..."
tar -xzf scribble.tar.gz
rm scribble.tar.gz

# Set up launcher
echo -e "${YELLOW}Setting up launcher...${NC}"
mkdir -p "$BIN_DIR" # Ensure bin directory exists
mv launcher.sh "$BIN_DIR/scribble" # Move launcher to bin and rename
chmod +x "$BIN_DIR/scribble"

# Add to PATH
echo -e "${YELLOW}Adding to PATH...${NC}"
SHELL_RC=""
if [ -f "$HOME/.bashrc" ]; then SHELL_RC="$HOME/.bashrc"; fi
if [ -f "$HOME/.zshrc" ]; then SHELL_RC="$HOME/.zshrc"; fi

if [ ! -z "$SHELL_RC" ] && ! grep -q "\.scribble/bin" "$SHELL_RC"; then
    echo "" >> "$SHELL_RC"
    echo "# Scribble installation" >> "$SHELL_RC"
    echo "export PATH=\"\${HOME}/.scribble/bin:\$PATH\"" >> "$SHELL_RC"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✓ Installation Complete!             ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Installation folder:${NC} $INSTALL_DIR"
echo -e "${BLUE}Launcher:${NC} $BIN_DIR/scribble"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Reload shell: source $SHELL_RC"
echo "  2. Run: scribble help"
echo "  3. Or use: $BIN_DIR/scribble build"
echo ""
echo -e "${GREEN}Auto-updates:${NC} Checks daily for changes on GitHub"
echo ""

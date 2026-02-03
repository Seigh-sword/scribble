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
for cmd in git cmake; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}✗ $cmd not found. Please install it first.${NC}"
        exit 1
    fi
done
echo -e "${GREEN}✓ All requirements met${NC}"
echo ""

# Download/update repo
echo -e "${YELLOW}Setting up Scribble...${NC}"
if [ -d "$INSTALL_DIR" ]; then
    echo -e "  Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull origin main
else
    echo -e "  Downloading from GitHub..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# Build with CMake
echo -e "${YELLOW}Building...${NC}"
cmake -S . -B build -DBUILD_SHARED_LIBS=ON
cmake --build build -j$(nproc)

# Create launcher wrapper
echo -e "${YELLOW}Creating launcher...${NC}"
mkdir -p "$BIN_DIR"

cat > "$BIN_DIR/scribble" << 'EOF'
#!/bin/bash
INSTALL_DIR="${HOME}/.scribble"
cd "$INSTALL_DIR"
# Auto-update check
if [ "$(date +%s)" -gt "$(stat -c %Y .last-update 2>/dev/null || echo 0)" + 86400 ]; then
    git pull origin main > /dev/null 2>&1 && cmake --build build -j$(nproc) > /dev/null 2>&1
    touch .last-update
fi
./ses "$@"
EOF

chmod +x "$BIN_DIR/scribble"

# Add to PATH
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

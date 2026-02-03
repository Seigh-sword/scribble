#!/bin/bash

# Scribble: Build Script
# Builds compiler, runtime, and attributes

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Scribble: Build${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Clean previous build
if [ -d "build" ]; then
    echo -e "${YELLOW}Cleaning old build...${NC}"
    rm -rf build
fi

# Build with CMake
echo -e "${BLUE}Building compiler and runtime...${NC}"
cmake -S . -B build
cmake --build build -j$(nproc)

echo ""
echo -e "${BLUE}Build Outputs:${NC}"
echo -e "  ${GREEN}✓ Compiler:${NC} $(ls -lh build/bin/scribblec | awk '{print $5}')"
echo -e "  ${GREEN}✓ Runtime:${NC} $(ls -lh build/bin/scribble_example | awk '{print $5}')"

# List generated files
echo ""
echo -e "${BLUE}Generated Files:${NC}"
ls -lh build/bin/ | tail -n +2 | awk '{printf "  %s (%s)\n", $9, $5}'

echo ""
echo -e "${GREEN}✓ Build complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  npm run check    - Check all files"
echo "  npm run compile  - Compile .scrib files"
echo "  npm run test     - Run tests"

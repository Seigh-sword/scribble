#!/bin/bash

# Scribble: Compile .scrib files
# Compiles a .scrib file to specified language

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ $# -lt 1 ]; then
    echo -e "${YELLOW}Usage: npm run compile -- <file.scrib> [--lang cpp|c|asm] [--output <file>]${NC}"
    echo ""
    echo "Examples:"
    echo "  npm run compile -- examples/hello.scrib"
    echo "  npm run compile -- examples/hello.scrib --lang c"
    echo "  npm run compile -- examples/hello.scrib --output generated.cpp"
    exit 1
fi

if [ ! -f "build/bin/scribblec" ]; then
    echo -e "${RED}✗ Compiler not built. Run 'npm run build' first.${NC}"
    exit 1
fi

echo -e "${BLUE}Compiling with Scribble...${NC}"
./build/bin/scribblec "$@"

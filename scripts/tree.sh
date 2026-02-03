#!/bin/bash

# Scribble: Display project tree
# Shows detailed project structure

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Scribble: Project Structure${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Try tree if available, otherwise use find
if command -v tree &> /dev/null; then
    tree -I 'build|.git|node_modules' --dirsfirst -L 4
else
    echo -e "${BLUE}Directory Structure:${NC}"
    find . -type d -not -path './build/*' -not -path './.git/*' -not -path './node_modules/*' | sort | sed 's|^\./||' | sed 's|[^/]*/| |g'
    
    echo ""
    echo -e "${BLUE}Files:${NC}"
    find . -type f -not -path './build/*' -not -path './.git/*' -not -path './node_modules/*' | sort | sed 's|^\./||'
fi

# Count statistics
echo ""
echo -e "${BLUE}Statistics:${NC}"
echo -e "  ${GREEN}C++ Files:${NC} $(find . -name "*.cpp" -o -name "*.h" | wc -l)"
echo -e "  ${GREEN}C Files:${NC} $(find . -name "*.c" | wc -l)"
echo -e "  ${GREEN}Assembly Files:${NC} $(find . -name "*.S" -o -name "*.s" | wc -l)"
echo -e "  ${GREEN}Rust Crates:${NC} $(find attributes -name "Cargo.toml" | wc -l)"
echo -e "  ${GREEN}Headers:${NC} $(find headers -name "*.header" | wc -l)"
echo -e "  ${GREEN}Total Lines (src):${NC} $(find compiler src -name "*.cpp" -o -name "*.h" -o -name "*.c" 2>/dev/null | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')"

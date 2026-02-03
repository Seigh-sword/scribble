#!/bin/bash

# Scribble: Linter
# Checks code style and potential issues

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Scribble: Code Linter${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

ISSUES=0

# Check for TODO comments
echo -e "${BLUE}Scanning for TODOs/FIXMEs:${NC}"
for file in compiler/src/*.cpp compiler/include/*.h; do
    if [ -f "$file" ]; then
        grep -n "TODO\|FIXME" "$file" | while read line; do
            echo -e "  ${YELLOW}⚠${NC} $file: $line"
            ((ISSUES++))
        done
    fi
done

# Check for trailing whitespace
echo -e "\n${BLUE}Checking for trailing whitespace:${NC}"
for file in compiler/src/*.cpp compiler/include/*.h src/*.c src/*.S; do
    if [ -f "$file" ]; then
        if grep -q '[[:space:]]$' "$file"; then
            echo -e "  ${YELLOW}⚠${NC} $file has trailing whitespace"
            ((ISSUES++))
        fi
    fi
done

# Check includes
echo -e "\n${BLUE}Checking include paths:${NC}"
for file in compiler/src/*.cpp; do
    if [ -f "$file" ]; then
        grep "#include" "$file" | while read include; do
            if echo "$include" | grep -q "#include.*\.cpp"; then
                echo -e "  ${RED}✗${NC} $file: $include (should not include .cpp)"
                ((ISSUES++))
            fi
        done
    fi
done

echo ""
if [ $ISSUES -eq 0 ]; then
    echo -e "${GREEN}✓ No style issues found!${NC}"
else
    echo -e "${YELLOW}⚠ Found $ISSUES potential issues${NC}"
fi

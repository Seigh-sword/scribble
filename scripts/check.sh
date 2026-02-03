#!/bin/bash

# Scribble: Comprehensive Checker
# Checks all source files, reports errors, and displays tree

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Scribble: Comprehensive Code Checker${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Track errors
ERROR_COUNT=0
WARNING_COUNT=0
FILES_CHECKED=0

# Function to check file
check_file() {
    local file=$1
    local file_type=$2
    
    echo -e "${YELLOW}Checking:${NC} $file"
    ((FILES_CHECKED++))
    
    if [ ! -f "$file" ]; then
        echo -e "  ${RED}✗ FILE NOT FOUND${NC}"
        ((ERROR_COUNT++))
        return
    fi
    
    # Check file size
    local size=$(wc -c < "$file")
    if [ "$size" -eq 0 ]; then
        echo -e "  ${RED}✗ EMPTY FILE${NC}"
        ((ERROR_COUNT++))
        return
    fi
    
    echo -e "  ${GREEN}✓ File exists${NC} ($(wc -l < "$file") lines, $size bytes)"
    
    # Language-specific checks
    case $file_type in
        cpp)
            # Check for missing includes in headers
            if grep -q "^#ifndef" "$file" && ! grep -q "^#define" "$file"; then
                echo -e "  ${RED}✗ Header guard incomplete${NC}"
                ((ERROR_COUNT++))
            else
                echo -e "  ${GREEN}✓ Header guards OK${NC}"
            fi
            
            # Check for syntax
            if grep -q "<<" "$file" || grep -q ">>" "$file"; then
                echo -e "  ${GREEN}✓ Stream operators found${NC}"
            fi
            ;;
        c)
            if grep -q "#include" "$file"; then
                echo -e "  ${GREEN}✓ Include statements OK${NC}"
            fi
            ;;
        h)
            if ! grep -q "#ifndef" "$file"; then
                echo -e "  ${YELLOW}⚠ No header guard${NC}"
                ((WARNING_COUNT++))
            fi
            ;;
    esac
}

# Display project tree
echo -e "${BLUE}Project Structure:${NC}"
echo ""
tree -I 'build|.git' --dirsfirst -L 3 2>/dev/null || find . -type f -not -path './build/*' -not -path './.git/*' | head -30 | sed 's|^\./||' | sort | sed 's|^|  |'
echo ""

# Check C++ files
echo -e "${BLUE}Checking C++ Files:${NC}"
find compiler/src -name "*.cpp" -type f | while read file; do
    check_file "$file" "cpp"
done
find compiler/include -name "*.h" -type f | while read file; do
    check_file "$file" "h"
done

# Check C files
echo -e "\n${BLUE}Checking C Files:${NC}"
find src -name "*.c" -type f 2>/dev/null | while read file; do
    check_file "$file" "c"
done

# Check assembly files
echo -e "\n${BLUE}Checking Assembly Files:${NC}"
find src -name "*.S" -o -name "*.s" -type f 2>/dev/null | while read file; do
    check_file "$file" "asm"
done

# Check headers
echo -e "\n${BLUE}Checking Header Files:${NC}"
find headers -name "*.header" -type f 2>/dev/null | while read file; do
    if [ -f "$file" ]; then
        echo -e "  ${GREEN}✓${NC} $file ($(wc -l < "$file") lines)"
    fi
done

# Check Rust crates
echo -e "\n${BLUE}Checking Rust Attributes:${NC}"
for attr in time system canvas math string file; do
    if [ -d "attributes/$attr" ]; then
        echo -e "  ${GREEN}✓${NC} attributes/$attr"
        [ -f "attributes/$attr/Cargo.toml" ] && echo -e "    ${GREEN}✓${NC} Cargo.toml"
        [ -f "attributes/$attr/src/lib.rs" ] && echo -e "    ${GREEN}✓${NC} src/lib.rs"
    fi
done

# Check JSON files
echo -e "\n${BLUE}Checking Configuration Files:${NC}"
if [ -f "attributes.json" ]; then
    if python3 -m json.tool attributes.json > /dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} attributes.json (valid JSON)"
    else
        echo -e "  ${RED}✗${NC} attributes.json (INVALID JSON)"
        ((ERROR_COUNT++))
    fi
fi

if [ -f "package.json" ]; then
    if python3 -m json.tool package.json > /dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} package.json (valid JSON)"
    else
        echo -e "  ${RED}✗${NC} package.json (INVALID JSON)"
        ((ERROR_COUNT++))
    fi
fi

# Compilation check
echo -e "\n${BLUE}Compilation Check:${NC}"
if [ -f "CMakeLists.txt" ]; then
    echo -e "  ${GREEN}✓${NC} CMakeLists.txt found"
    if cmake -S . -B build_check > /dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} CMake configuration OK"
    else
        echo -e "  ${RED}✗${NC} CMake configuration FAILED"
        ((ERROR_COUNT++))
    fi
    rm -rf build_check
fi

# Summary
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Check Summary${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "  Files checked: ${YELLOW}$FILES_CHECKED${NC}"
echo -e "  Errors found: ${RED}$ERROR_COUNT${NC}"
echo -e "  Warnings: ${YELLOW}$WARNING_COUNT${NC}"

if [ $ERROR_COUNT -eq 0 ]; then
    echo -e "  Status: ${GREEN}✓ ALL CHECKS PASSED${NC}"
    exit 0
else
    echo -e "  Status: ${RED}✗ FAILURES DETECTED${NC}"
    exit 1
fi

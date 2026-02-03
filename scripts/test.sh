#!/bin/bash

# Scribble: Test Script
# Runs compiler tests

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Scribble: Tests${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

if [ ! -f "build/bin/scribblec" ]; then
    echo -e "${RED}✗ Compiler not built. Run 'npm run build' first.${NC}"
    exit 1
fi

TESTS_PASSED=0
TESTS_FAILED=0

# Test 1: Compiler help
echo -e "${BLUE}Test 1: Compiler Help${NC}"
if ./build/bin/scribblec 2>&1 | grep -q "Usage"; then
    echo -e "  ${GREEN}✓ PASS${NC}"
    ((TESTS_PASSED++))
else
    echo -e "  ${RED}✗ FAIL${NC}"
    ((TESTS_FAILED++))
fi

# Test 2: Compile to C++
echo -e "${BLUE}Test 2: Compile to C++${NC}"
if ./build/bin/scribblec examples/hello.scrib -o /tmp/test.cpp --lang cpp 2>&1 | grep -q "Compiled"; then
    if grep -q "#include" /tmp/test.cpp; then
        echo -e "  ${GREEN}✓ PASS${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "  ${RED}✗ FAIL (no includes)${NC}"
        ((TESTS_FAILED++))
    fi
else
    echo -e "  ${RED}✗ FAIL${NC}"
    ((TESTS_FAILED++))
fi

# Test 3: Compile to C
echo -e "${BLUE}Test 3: Compile to C${NC}"
if ./build/bin/scribblec examples/hello.scrib -o /tmp/test.c --lang c 2>&1 | grep -q "Compiled"; then
    if grep -q "stdio.h" /tmp/test.c; then
        echo -e "  ${GREEN}✓ PASS${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "  ${RED}✗ FAIL (missing stdio.h)${NC}"
        ((TESTS_FAILED++))
    fi
else
    echo -e "  ${RED}✗ FAIL${NC}"
    ((TESTS_FAILED++))
fi

# Test 4: Compile to Assembly
echo -e "${BLUE}Test 4: Compile to Assembly${NC}"
if ./build/bin/scribblec examples/hello.scrib -o /tmp/test.s --lang asm 2>&1 | grep -q "Compiled"; then
    if grep -q "\.text" /tmp/test.s; then
        echo -e "  ${GREEN}✓ PASS${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "  ${RED}✗ FAIL (no .text section)${NC}"
        ((TESTS_FAILED++))
    fi
else
    echo -e "  ${RED}✗ FAIL${NC}"
    ((TESTS_FAILED++))
fi

# Test 5: Runtime example
echo -e "${BLUE}Test 5: Runtime Example${NC}"
if ./build/bin/scribble_example 2>&1 | grep -q "c_func returned"; then
    echo -e "  ${GREEN}✓ PASS${NC}"
    ((TESTS_PASSED++))
else
    echo -e "  ${RED}✗ FAIL${NC}"
    ((TESTS_FAILED++))
fi

# Summary
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Test Summary${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "  Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "  Failed: ${RED}$TESTS_FAILED${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "  Status: ${GREEN}✓ ALL TESTS PASSED${NC}"
    exit 0
else
    echo -e "  Status: ${RED}✗ SOME TESTS FAILED${NC}"
    exit 1
fi

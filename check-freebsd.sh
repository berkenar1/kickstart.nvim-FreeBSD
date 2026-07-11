#!/bin/sh
# FreeBSD Health Check Script for kickstart.nvim
# Validates that all dependencies are properly installed

set -e

echo "=== FreeBSD Neovim Dependencies Health Check ==="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_cmd() {
    local cmd=$1
    local name=$2
    
    if command -v "$cmd" &> /dev/null; then
        echo "${GREEN}✓${NC} $name is installed"
        return 0
    else
        echo "${RED}✗${NC} $name is NOT installed"
        return 1
    fi
}

check_pkg() {
    local pkg=$1
    local name=$2
    
    if pkg info -e "$pkg" > /dev/null 2>&1; then
        echo "${GREEN}✓${NC} $name is installed"
        return 0
    else
        echo "${RED}✗${NC} $name is NOT installed"
        return 1
    fi
}

failed=0

echo "Checking core tools..."
check_cmd "nvim" "Neovim" || failed=$((failed+1))
check_cmd "git" "Git" || failed=$((failed+1))
check_cmd "gmake" "GNU Make (gmake)" || failed=$((failed+1))
check_cmd "unzip" "Unzip" || failed=$((failed+1))

echo ""
echo "Checking development tools..."
check_pkg "llvm" "LLVM/Clang" || failed=$((failed+1))
check_cmd "rg" "Ripgrep" || failed=$((failed+1))
check_cmd "fd" "Fd" || failed=$((failed+1))

echo ""
echo "Checking syntax highlighting..."
check_cmd "tree-sitter" "Tree-sitter" || failed=$((failed+1))

echo ""
echo "Checking formatters..."
check_cmd "stylua" "Stylua" || failed=$((failed+1))

echo ""
echo "Checking optional tools..."
check_cmd "base64" "Base64" || echo "${YELLOW}!${NC} Base64 (optional) not found"
check_cmd "xclip" "Xclip (clipboard)" || echo "${YELLOW}!${NC} Xclip (optional) not found"

echo ""
echo "Checking Neovim config..."
if [ -f "$HOME/.config/nvim/init.lua" ]; then
    echo "${GREEN}✓${NC} Neovim config found at ~/.config/nvim/init.lua"
else
    echo "${RED}✗${NC} Neovim config NOT found"
    failed=$((failed+1))
fi

echo ""
if [ $failed -eq 0 ]; then
    echo "${GREEN}All dependencies are installed!${NC}"
    echo ""
    echo "You can start Neovim with: nvim"
    exit 0
else
    echo "${RED}$failed dependency/dependencies are missing.${NC}"
    echo ""
    echo "Install missing dependencies with: sudo sh install-freebsd.sh"
    exit 1
fi

#!/bin/sh
# FreeBSD Dependencies Installation Script for kickstart.nvim
# This script installs all required dependencies for kickstart.nvim on FreeBSD

set -e

echo "Installing dependencies for kickstart.nvim on FreeBSD..."
echo ""

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Update package database
echo "[1/5] Updating package database..."
pkg update -f

# Core dependencies
echo "[2/5] Installing core dependencies (git, make, unzip, clang)..."
pkg install -y base64 git gmake unzip llvm

# Development tools
echo "[3/5] Installing development tools (ripgrep, fd)..."
pkg install -y ripgrep fd-find

# Tree-sitter for syntax highlighting
echo "[4/5] Installing tree-sitter..."
pkg install -y tree-sitter

# Code formatter
echo "[5/5] Installing code formatters (stylua)..."
pkg install -y stylua

echo ""
echo "✓ All dependencies installed successfully!"
echo ""
echo "Next steps:"
echo "1. Start Neovim: nvim"
echo "2. Install plugins: :Lazy sync"
echo "3. (Optional) Set a Nerd Font in your terminal and update vim.g.have_nerd_font = true in init.lua"
echo ""

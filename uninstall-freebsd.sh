#!/bin/sh
# FreeBSD Uninstall Script for kickstart.nvim
# Cleanly removes the Neovim configuration

set -e

echo "=== Uninstalling kickstart.nvim-FreeBSD ==="
echo ""

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Confirmation
echo "${YELLOW}WARNING: This will delete your Neovim configuration!${NC}"
echo "The following will be removed:"
echo "  - ~/.config/nvim"
echo "  - ~/.local/share/nvim"
echo ""
read -p "Are you sure? (type 'yes' to confirm): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo ""
echo "Uninstalling..."

# Backup option
if [ -d "$HOME/.config/nvim" ]; then
    echo ""
    read -p "Create a backup before deleting? (y/n): " backup
    if [ "$backup" = "y" ] || [ "$backup" = "Y" ]; then
        backup_dir="$HOME/nvim-backup-$(date +%Y%m%d-%H%M%S)"
        echo "Creating backup at $backup_dir..."
        cp -r "$HOME/.config/nvim" "$backup_dir"
        echo "${GREEN}✓ Backup created${NC}"
    fi
fi

# Remove config
echo "Removing ~/.config/nvim..."
rm -rf "$HOME/.config/nvim"

# Remove plugin data
echo "Removing ~/.local/share/nvim..."
rm -rf "$HOME/.local/share/nvim"

# Remove state
echo "Removing ~/.local/state/nvim..."
rm -rf "$HOME/.local/state/nvim"

echo ""
echo "${GREEN}✓ Uninstall complete!${NC}"
echo ""
echo "To reinstall, run:"
echo "  git clone https://github.com/YOUR_USERNAME/kickstart.nvim-freebsd.git ~/.config/nvim"
echo "  cd ~/.config/nvim"
echo "  sudo sh install-freebsd.sh"
echo "  nvim +Lazy sync +q"

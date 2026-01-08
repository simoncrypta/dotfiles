#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Dotfiles Installation Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: GNU Stow is not installed.${NC}"
    echo -e "${YELLOW}Install it with: sudo pacman -S stow${NC}"
    exit 1
fi

echo -e "${GREEN}✓ GNU Stow found${NC}"

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo -e "${YELLOW}Working directory: $DOTFILES_DIR${NC}"
echo ""

# Define modules
MODULES=(hypr waybar ghostty nvim cursor)

# Function to backup existing config
backup_config() {
    local module=$1
    local config_path=""
    
    case $module in
        cursor)
            config_path="$HOME/.config/Cursor/User"
            ;;
        *)
            config_path="$HOME/.config/$module"
            ;;
    esac
    
    if [ -d "$config_path" ] && [ ! -L "$config_path" ]; then
        echo -e "${YELLOW}Backing up existing $module config...${NC}"
        mv "$config_path" "${config_path}.backup.$(date +%Y%m%d%H%M%S)"
    fi
}

# Function to stow a module
stow_module() {
    local module=$1
    echo -e "Installing ${GREEN}$module${NC}..."
    
    # Backup existing config if it exists and is not a symlink
    backup_config "$module"
    
    # Stow the module
    if stow -t "$HOME" "$module" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} $module installed"
    else
        echo -e "  ${RED}✗${NC} $module failed (may already be symlinked or conflict exists)"
        echo -e "  ${YELLOW}Try: stow -D -t ~ $module && stow -t ~ $module${NC}"
    fi
}

# Parse arguments
if [ $# -eq 0 ]; then
    # Install all modules
    echo -e "${GREEN}Installing all modules...${NC}"
    echo ""
    for module in "${MODULES[@]}"; do
        stow_module "$module"
    done
else
    # Install specified modules
    for module in "$@"; do
        if [[ " ${MODULES[*]} " =~ " ${module} " ]]; then
            stow_module "$module"
        else
            echo -e "${RED}Unknown module: $module${NC}"
            echo -e "${YELLOW}Available modules: ${MODULES[*]}${NC}"
        fi
    done
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "Symlinks created. Verify with:"
echo -e "  ${YELLOW}find ~/.config -type l | grep dotfiles${NC}"
echo ""
echo -e "Reload configs:"
echo -e "  ${YELLOW}hyprctl reload${NC}  # Hyprland"
echo -e "  ${YELLOW}pkill waybar && waybar &${NC}  # Waybar"
echo ""

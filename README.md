# My Omarchy Dotfiles

Personal dotfiles for my Omarchy/Hyprland setup managed with GNU Stow.

## Overview

This repository contains my custom configurations for:
- **Hyprland** - Wayland tiling window manager
- **Waybar** - Status bar with custom modules  
- **Ghostty** - Terminal emulator
- **Neovim** - Text editor (LazyVim based)
- **Cursor** - AI-powered code editor
- **Omarchy** - Custom themes and configurations

## Installation

### Prerequisites

```bash
# Install GNU Stow (Arch Linux)
sudo pacman -S stow

# Verify installation
stow --version
```

### Clone and Setup

```bash
# Clone this repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Backup existing configs (optional but recommended)
mkdir -p ~/.config-backup
cp -r ~/.config/hypr ~/.config-backup/ 2>/dev/null
cp -r ~/.config/waybar ~/.config-backup/ 2>/dev/null
cp -r ~/.config/ghostty ~/.config-backup/ 2>/dev/null
cp -r ~/.config/nvim ~/.config-backup/ 2>/dev/null
cp -r ~/.config/Cursor ~/.config-backup/ 2>/dev/null
cp -r ~/.config/omarchy ~/.config-backup/ 2>/dev/null

# Remove existing configs (required for stow to create symlinks)
rm -rf ~/.config/hypr ~/.config/waybar ~/.config/ghostty ~/.config/nvim ~/.config/Cursor/User ~/.config/omarchy

# Install all configurations
stow -t ~ hypr waybar ghostty nvim cursor omarchy

# Or install individual modules
stow -t ~ hypr
stow -t ~ waybar
stow -t ~ ghostty
stow -t ~ nvim
stow -t ~ cursor
stow -t ~ omarchy
```

## Module Structure

Each application has its own module following the stow convention:

```
~/dotfiles/
├── hypr/                    # Hyprland window manager
│   └── .config/hypr/
│       ├── hyprland.conf
│       ├── monitors.conf
│       ├── bindings.conf
│       ├── input.conf
│       ├── looknfeel.conf
│       ├── hypridle.conf
│       ├── hyprlock.conf
│       └── ...
├── waybar/                  # Status bar
│   └── .config/waybar/
│       ├── config.jsonc
│       ├── style.css
│       └── hyprwhspr-module.jsonc
├── ghostty/                 # Terminal emulator
│   └── .config/ghostty/
│       └── config
├── nvim/                    # Neovim editor
│   └── .config/nvim/
│       ├── init.lua
│       ├── lua/
│       └── ...
├── cursor/                  # Cursor editor
│   └── .config/Cursor/
│       └── User/
│           ├── settings.json
│           └── keybindings.json
└── omarchy/                 # Omarchy customizations
    └── .config/omarchy/
        ├── themes/
        ├── hooks/
        └── branding/
```

## Usage

### Add New Configurations

```bash
# 1. Create module directory structure
mkdir -p ~/dotfiles/newapp/.config/newapp/

# 2. Move your existing config
mv ~/.config/newapp/config ~/dotfiles/newapp/.config/newapp/

# 3. Stow the new module
cd ~/dotfiles && stow -t ~ newapp

# 4. Commit changes
git add newapp/
git commit -m "Add newapp configuration"
```

### Update Existing Configs

Edit files directly in `~/.config/` — they're symlinks pointing to `~/dotfiles/`:

```bash
# Edit config (changes are made in ~/dotfiles/)
nvim ~/.config/hypr/bindings.conf

# Commit your changes
cd ~/dotfiles
git add .
git commit -m "Update Hyprland keybindings"
git push
```

### Remove Symlinks

```bash
cd ~/dotfiles

# Remove specific module
stow -D -t ~ hypr

# Remove all modules
stow -D -t ~ hypr waybar ghostty nvim cursor omarchy
```

### Reinstall/Refresh Symlinks

```bash
cd ~/dotfiles

# Restow (remove and reinstall)
stow -R -t ~ hypr waybar ghostty nvim cursor omarchy
```

## Omarchy Compatibility

This setup works seamlessly with Omarchy:

1. **Your configs override Omarchy defaults** — Files in `~/.config/` take precedence over `~/.local/share/omarchy/`
2. **Easy to merge updates** — After Omarchy updates, review changes and selectively merge
3. **No conflicts** — Your custom configs are managed separately from Omarchy's system files

### Workflow for Omarchy Updates

```bash
# 1. Update Omarchy
omarchy update

# 2. Check what changed in your configs
cd ~/dotfiles
git status

# 3. Review any backup files Omarchy created
find ~/.config -name "*.bak*" -newer ~/dotfiles/.git/HEAD

# 4. Merge desired changes into your configs
# Edit files in ~/.config/ directly

# 5. Commit your updates
git add .
git commit -m "Merge Omarchy updates"
git push
```

## Troubleshooting

### Stow Reports Conflicts

```bash
# Check what would be stowed (dry run)
stow -n -t ~ hypr

# If conflicts exist, backup and remove the conflicting files
mv ~/.config/hypr ~/.config/hypr.backup
stow -t ~ hypr
```

### Symlinks Not Working

```bash
# Verify symlinks were created
ls -la ~/.config/hypr/

# Should show something like:
# hyprland.conf -> ../../dotfiles/hypr/.config/hypr/hyprland.conf
```

### Configs Not Applied After Changes

Restart the relevant application:

```bash
# Hyprland - reload config
hyprctl reload

# Waybar - restart
pkill waybar && waybar &

# Ghostty - close and reopen terminal

# Neovim - restart nvim
```

### Check Symlink Integrity

```bash
# List all symlinks pointing to dotfiles
find ~/.config -type l -exec ls -l {} \; 2>/dev/null | grep dotfiles

# Verify stow structure
cd ~/dotfiles
stow -n -t ~ *  # Dry run shows what would be symlinked
```

## Quick Reference

```bash
# Install all modules
cd ~/dotfiles && stow -t ~ hypr waybar ghostty nvim cursor omarchy

# Remove all modules  
cd ~/dotfiles && stow -D -t ~ hypr waybar ghostty nvim cursor omarchy

# Reinstall all modules
cd ~/dotfiles && stow -R -t ~ hypr waybar ghostty nvim cursor omarchy

# Dry run (see what would happen)
cd ~/dotfiles && stow -n -t ~ *

# Add changes
cd ~/dotfiles && git add . && git commit -m "Update configs"

# Push to remote
cd ~/dotfiles && git push

# Pull latest
cd ~/dotfiles && git pull
```

## Credits

- [Omarchy](https://omarchy.org/) - Base system
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink management
- [Omarchy Dotfiles Discussion](https://github.com/basecamp/omarchy/discussions/191) - Community insights
- [sspaeti's dotfiles](https://dotfiles.ssp.sh) - Inspiration for stow structure

#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/PartitionPixel/dotfiles.git"

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
sudo pacman -S --noconfirm stow
cd ~/dotfiles/.config

# Remove old Hyprland config if it exists
if [ -f "$HOME/.config/hypr/hyprland.conf" ] && [ ! -L "$HOME/.config/hypr/hyprland.conf" ]; then
    echo "Removing existing Hyprland config..."
    rm -f "$HOME/.config/hypr/hyprland.conf"
fi

stow -R hypr
echo "✅ Hyprland config deployed from dotfiles"

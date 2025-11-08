#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/PartitionPixel/dotfiles.git"

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
sudo pacman -S --noconfirm stow

# Remove old Hyprland config if it exists
if [ -f "$HOME/.config/hypr/hyprland.conf" ] && [ ! -L "$HOME/.config/hypr/hyprland.conf" ]; then
    echo "Removing existing Hyprland config..."
    rm -f "$HOME/.config/hypr/hyprland.conf"
fi

stow -R hypr
echo "✅ Hyprland config deployed from dotfiles"

# Reload Hyprland config if Hyprland is running
if pgrep -x "Hyprland" > /dev/null; then
    echo "Reloading Hyprland configuration..."
    hyprctl reload && echo "✅ Hyprland reloaded"
else
    echo "ℹ️ Hyprland is not running; skipping reload"
fi


#!/usr/bin/env bash
set -e

mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Videos/Recording

echo "==> Enabling multilib repository..."

# Check if already enabled
if grep -Eq "^\[multilib\]" /etc/pacman.conf; then
    echo "✔️  Multilib already enabled."
else
    # Uncomment lines
    sudo sed -i '/#\[multilib\]/,/#Include = \/etc\/pacman\.d\/mirrorlist/ s/^#//' /etc/pacman.conf
    echo "✔️  Multilib enabled successfully."
fi

echo "==> Refreshing pacman databases..."
sudo pacman -Syy
echo "✔️  Database refreshed."

echo "==> Updating system..."
sudo pacman -Syu --noconfirm
echo "✔️  System updated."

sudo pacman -S --noconfirm git base-devel
sudo pacman -S --noconfirm linux-zen linux-zen-headers
sudo pacman -S --noconfirm nvidia-open-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
sudo pacman -S --noconfirm swaync
sudo pacman -S --noconfirm hypridle hyprpaper
sudo pacman -S --noconfirm polkit


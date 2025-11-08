#!/usr/bin/env bash
set -e

mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Videos/Recording

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel
sudo pacman -S --noconfirm linux-zen linux-zen-headers
sudo pacman -S --noconfirm nvidia-open-dkms nvidia-utils lib32-nvidia-open-utils nvidia-settings
sudo pacman -S --noconfirm swaync
sudo pacman -S --noconfirm hypridle hyprpaper
sudo pacman -S --noconfirm polkit


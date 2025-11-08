#!/usr/bin/env bash
set -e

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel
sudo pacman -S --noconfirm linux-zen linux-zen-headers
sudo pacman -S --noconfirm nvidia-open-dkms nvidia-open-utils lib32-nvidia-open-utils nvidia-settings


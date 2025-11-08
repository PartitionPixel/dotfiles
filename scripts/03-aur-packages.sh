#!/usr/bin/env bash
set -e

AUR_PACKAGES=(
  "brave-bin"
)

for pkg in "${AUR_PACKAGES[@]}"; do
  yay -S --noconfirm "$pkg"
done

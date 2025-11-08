#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/PartitionPixel/dotfiles.git"

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
sudo pacman -S --noconfirm stow
stow hypr

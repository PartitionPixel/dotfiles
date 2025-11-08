#!/usr/bin/env bash

set -eEuo pipefail

# === CONFIG ===
LOG_FILE="$HOME/setup.log"
DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/PartitionPixel/ArchLinux.git"

# === HELPERS ===
log() {
  echo -e "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

ok() {
  echo -e "✅ $*" | tee -a "$LOG_FILE"
}

fail() {
  echo -e "❌ $*" | tee -a "$LOG_FILE"
}

trap 'fail "Error on line $LINENO. Check $LOG_FILE for details."' ERR

# === SCRIPT ===
log "=== ArchLinux Post-Install Script Started ==="

log "Updating system packages..."
if sudo pacman -Syu --noconfirm >>"$LOG_FILE" 2>&1; then
  ok "System updated successfully."
else
  fail "System update failed."
  exit 1
fi

log "Installing essential packages (git, stow)..."
if sudo pacman -S --noconfirm git stow >>"$LOG_FILE" 2>&1; then
  ok "Installed git and stow."
else
  fail "Failed to install git/stow."
  exit 1
fi

log "Cloning dotfiles repository..."
if [ ! -d "$DOTFILES_DIR" ]; then
  if git clone "$REPO_URL" "$DOTFILES_DIR" >>"$LOG_FILE" 2>&1; then
    ok "Dotfiles repository cloned to $DOTFILES_DIR."
  else
    fail "Failed to clone dotfiles repository."
    exit 1
  fi
else
  ok "Dotfiles repo already exists at $DOTFILES_DIR. Skipping clone."
fi

cd "$DOTFILES_DIR"

log "Deploying dotfiles with GNU Stow..."
STOW_TARGETS=("hypr") # Add more like "waybar" "kitty" etc.

for target in "${STOW_TARGETS[@]}"; do
  if stow "$target" >>"$LOG_FILE" 2>&1; then
    ok "Stowed '$target' successfully."
  else
    fail "Failed to stow '$target'."
  fi
done

ok "All selected configs deployed successfully."
log "=== Setup Complete ==="

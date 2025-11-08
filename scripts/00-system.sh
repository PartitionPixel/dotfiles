#!/usr/bin/env bash
set -e

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel

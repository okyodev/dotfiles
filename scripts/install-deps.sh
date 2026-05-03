#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=detect-os.sh
source "$SCRIPT_DIR/detect-os.sh"

install_starship_via_curl() {
  if ! command -v starship >/dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
  fi
}

case "$OS" in
  macos)
    if ! command -v brew >/dev/null; then
      echo "Homebrew not found. Install it from https://brew.sh, then re-run." >&2
      exit 1
    fi
    brew install tmux neovim zsh stow starship git ripgrep
    ;;
  debian)
    sudo apt-get update
    sudo apt-get install -y tmux neovim zsh stow git curl ripgrep
    install_starship_via_curl
    ;;
  arch)
    sudo pacman -S --needed --noconfirm tmux neovim zsh stow starship git ripgrep
    ;;
  fedora)
    sudo dnf install -y tmux neovim zsh stow starship git ripgrep
    ;;
  *)
    echo "Unsupported OS. Install tmux, neovim, zsh, stow, starship, git, ripgrep manually, then re-run." >&2
    exit 1
    ;;
esac

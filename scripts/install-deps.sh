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

install_lazygit_via_github() {
  if command -v lazygit >/dev/null; then return 0; fi
  local arch tmp version
  case "$(uname -m)" in
    x86_64)         arch="x86_64" ;;
    aarch64|arm64)  arch="arm64"  ;;
    *) echo "Unsupported arch for lazygit: $(uname -m)" >&2; return 1 ;;
  esac
  version="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
    | grep -oE '"tag_name": *"v[^"]+"' | sed -E 's/.*"v([^"]+)"/\1/')"
  tmp="$(mktemp -d)"
  curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_Linux_${arch}.tar.gz" \
    -o "${tmp}/lazygit.tar.gz"
  tar -xzf "${tmp}/lazygit.tar.gz" -C "${tmp}" lazygit
  sudo install -m 755 "${tmp}/lazygit" /usr/local/bin/lazygit
  rm -rf "${tmp}"
}

case "$OS" in
  macos)
    if ! command -v brew >/dev/null; then
      echo "Homebrew not found. Install it from https://brew.sh, then re-run." >&2
      exit 1
    fi
    brew install tmux neovim zsh stow starship git ripgrep lazygit
    ;;
  debian)
    sudo apt-get update
    sudo apt-get install -y tmux neovim zsh stow git curl ripgrep tar
    install_starship_via_curl
    install_lazygit_via_github
    ;;
  arch)
    sudo pacman -S --needed --noconfirm tmux neovim zsh stow starship git ripgrep lazygit
    ;;
  fedora)
    sudo dnf install -y tmux neovim zsh stow starship git ripgrep lazygit
    ;;
  *)
    echo "Unsupported OS. Install tmux, neovim, zsh, stow, starship, git, ripgrep, lazygit manually, then re-run." >&2
    exit 1
    ;;
esac

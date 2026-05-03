#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
PACKAGES=(tmux nvim zsh starship)

# Targets that stow may collide with on a fresh machine.
# If they exist as real files (not symlinks), back them up first.
BACKUP_TARGETS=(
  "$HOME/.tmux.conf"
  "$HOME/.zshrc"
  "$HOME/.zprofile"
  "$HOME/.config/nvim"
  "$HOME/.config/starship.toml"
)

backup_existing_configs() {
  local stamp
  stamp="$(date +%s)"
  for target in "${BACKUP_TARGETS[@]}"; do
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "Backing up $target -> ${target}.bak.${stamp}"
      mv "$target" "${target}.bak.${stamp}"
    fi
  done
}

main() {
  source "$DOTFILES_DIR/scripts/detect-os.sh"
  echo "Detected OS: $OS"

  "$DOTFILES_DIR/scripts/install-deps.sh"

  backup_existing_configs

  mkdir -p "$HOME/.config"

  cd "$DOTFILES_DIR/packages"
  for pkg in "${PACKAGES[@]}"; do
    stow -v --target="$HOME" --restow "$pkg"
  done

  "$DOTFILES_DIR/scripts/set-default-shell.sh"

  echo
  echo "Done. Open a new terminal to pick up the new shell."
  echo "To apply the recommended terminal style, see README -> 'Terminal style (recommend)'."
}

main "$@"

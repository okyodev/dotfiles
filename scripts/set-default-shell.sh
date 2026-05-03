#!/usr/bin/env bash
set -euo pipefail

ZSH_PATH="$(command -v zsh)"

if [ -z "$ZSH_PATH" ]; then
  echo "zsh not installed; skipping default-shell change." >&2
  exit 0
fi

# Already the default? Nothing to do.
if [ "${SHELL:-}" = "$ZSH_PATH" ]; then
  exit 0
fi

# Make sure zsh is a valid login shell on this system.
if ! grep -qx "$ZSH_PATH" /etc/shells; then
  echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

chsh -s "$ZSH_PATH"
echo "Default shell set to zsh. Open a new terminal for it to take effect."

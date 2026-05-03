# dotfiles

Portable work environment: tmux, Neovim, zsh, starship, and a small shader payload. One script to set up a new machine.

## What's inside

| Package    | Target                    | Notes                                                                          |
| ---------- | ------------------------- | ------------------------------------------------------------------------------ |
| `tmux`     | `~/.tmux.conf`            | Ctrl-a prefix, vi mode, tmux.nvim navigation                                   |
| `nvim`     | `~/.config/nvim/`         | lazy.nvim + custom colorscheme, `lazy-lock.json` versioned for reproducibility |
| `zsh`      | `~/.zshrc`, `~/.zprofile` | Sources starship if installed                                                  |
| `starship` | `~/.config/starship.toml` | Cross-shell prompt                                                             |
| `shaders/` | (top-level, manual)       | `.glsl` shader payload — not auto-installed, see below                         |

## Install

```bash
git clone https://github.com/<your-user>/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

Supports macOS (Homebrew) and Linux (apt / pacman / dnf). The script:

1. Detects the OS
2. Installs `tmux`, `neovim`, `zsh`, `stow`, `starship`, `git`, `ripgrep`
3. Backs up any non-symlink configs already at the target paths
4. Symlinks every package via GNU stow
5. Sets zsh as the default login shell

It is idempotent — re-run it anytime.

## Manual dependencies

These are not installed by `install.sh`:

- **FiraCode Nerd Font** — download from <https://www.nerdfonts.com>

## Terminal style (recommend)

Recommended terminal look. Apply manually in your terminal's config:

```
padding = 10
theme   = Retro Legends (https://iterm2colorschemes.com/)
font    = FiraCode Nerd Font
```

The `shaders/` folder ships three `.glsl` payloads (`cursor_warp`, `sonic_boom_cursor`, `chromatic_glow`). To use them, link the folder into your terminal's shader directory and enable one of them in your terminal config — for example:

```bash
ln -sfn ~/dotfiles/shaders ~/.config/<your-terminal>/shaders
```

```
custom-shader = shaders/cursor_warp.glsl
```

## Per-package usage

Each subdirectory under `packages/` is an independent stow package. Install or remove them individually:

```bash
cd ~/dotfiles/packages
stow -v --target="$HOME" --restow nvim   # install or refresh
stow -v --target="$HOME" -D nvim          # uninstall (removes symlinks only)
```

## Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```

## Layout

```
~/dotfiles/
├── README.md
├── install.sh
├── .gitignore
├── shaders/                # portable .glsl payload
├── scripts/                # detect-os, install-deps, set-default-shell
└── packages/               # one stow package per tool
    ├── tmux/
    ├── nvim/
    ├── zsh/
    └── starship/
```

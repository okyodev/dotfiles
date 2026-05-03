#!/usr/bin/env bash
# Sets OS=macos|debian|arch|fedora|unknown for consumers to source.

case "$(uname -s)" in
  Darwin)
    OS="macos"
    ;;
  Linux)
    if   [ -f /etc/debian_version ]; then OS="debian"
    elif [ -f /etc/arch-release   ]; then OS="arch"
    elif [ -f /etc/fedora-release ]; then OS="fedora"
    else OS="unknown"
    fi
    ;;
  *)
    OS="unknown"
    ;;
esac

export OS

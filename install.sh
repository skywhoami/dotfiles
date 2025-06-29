#!/bin/bash
set -e

echo "[*] Bootstrapping dotfiles..."

if [[ "$(uname -s)" == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    echo "[*] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "[*] Installing Brew packages..."
  brew bundle --file=./Brewfile

  echo "[*] Applying macOS preferences..."
  sh .osx
else
  echo "[*] Not macOS (detected $OS), skipping Homebrew and macOS prefs..."
fi

echo "[*] Stowing dotfiles..."
stow .

echo "[✓] Done."
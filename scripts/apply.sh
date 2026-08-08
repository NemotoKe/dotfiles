#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/karabiner"
mkdir -p "$HOME/.hammerspoon"

cp "$DOTFILES/vim/.vimrc" \
   "$HOME/.vimrc"

cp "$DOTFILES/nvim/init.vim" \
   "$HOME/.config/nvim/init.vim"

rsync -a --delete \
  "$DOTFILES/ghostty/" \
  "$HOME/.config/ghostty/"

cp "$DOTFILES/karabiner/karabiner.json" \
   "$HOME/.config/karabiner/karabiner.json"

cp "$DOTFILES/zsh/.zshrc" \
   "$HOME/.zshrc"

rsync -a --delete \
  "$DOTFILES/hammerspoon/" \
  "$HOME/.hammerspoon/"

echo "dotfiles applied"

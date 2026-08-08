#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

mkdir -p "$DOTFILES/vim"
mkdir -p "$DOTFILES/nvim"
mkdir -p "$DOTFILES/ghostty"
mkdir -p "$DOTFILES/karabiner"

cp "$HOME/.vimrc" \
   "$DOTFILES/vim/.vimrc"

cp "$HOME/.config/nvim/init.vim" \
   "$DOTFILES/nvim/init.vim"

rsync -a "$HOME/.config/ghostty/" "$DOTFILES/ghostty/"

cp "$HOME/.config/karabiner/karabiner.json" \
   "$DOTFILES/karabiner/karabiner.json"

echo "dotfiles backed up"

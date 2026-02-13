#!/usr/bin/env bash

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -h|--help)
      HELP=Y
      ;;
    -o|--overwrite)
      OVERWRITE=Y
      ;;
    *)
      echo "Unknown option: $1. Use -h/--help to get help."
      ;;
  esac
  shift
done

if [[ $HELP == "Y" ]]; then
  echo "USAGE"
  echo "  ./setup.sh [flags]"
  echo
  echo "FLAGS"
  echo "  -h | --help        - Print this help"
  echo "  -o | --overwrite   - Overwrite files if they already exist"
  echo

  exit
fi

function createVimTempDirs {
  mkdir -p "$HOME/.vim/tmp/backup"
  mkdir -p "$HOME/.vim/tmp/undo"
  mkdir -p "$HOME/.vim/tmp/swap"
  mkdir -p "$HOME/.vim/tmp/view"
}

function createNeoVimConfiguration {
  mkdir -p "$HOME/.config/nvim"
  echo "
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc" > "$HOME/.config/nvim/init.vim"
}

source_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function createDotfileLinks {
  dotfiles_dir="$source_dir/dotfiles"

  shopt -s dotglob # also iterate hidden files with glob
  for f in "$dotfiles_dir"/*
  do
    f="$(basename $f)"
    dest="$HOME/$f"
    if [ ! -f "$dest" ] && [ ! -h "$dest" ]; then
      ln -s "$dotfiles_dir/$f" "$dest"
      echo "$f - linked OK"
    else
      if [[ $OVERWRITE == "Y" ]]; then
        rm -rf "$dest"
        ln -s "$dotfiles_dir/$f" "$dest"
        echo "$f - overwritten!"
      else
        echo "$f - already present (not overwritten; use -o to overwrite)"
      fi
    fi
  done
  shopt -u dotglob
}

function linkToBinDir {
  src="$source_dir/bin"
  dest="$HOME/.bin_wolf"
  if [ ! -d "$dest" ] && [ ! -h "$dest" ]; then
    ln -s "$src" "$dest"
    echo "Link to bin directory created."
  else
    if [[ $OVERWRITE == "Y" ]]; then
      rm -rf "$dest"
      ln -s "$src" "$dest"
      echo "Link to bin directory overwritten."
    else
      echo "Bin directory already present (not overwritten; use -o to overwrite)"
    fi
  fi
}

createVimTempDirs
createNeoVimConfiguration
createDotfileLinks
linkToBinDir


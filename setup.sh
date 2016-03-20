#!/bin/bash

function installVundleForVimPlugins {
  vundle_dir="$HOME/.vim/bundle/Vundle.vim"
  if [ ! -d "$vundle_dir" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $vundle_dir 
  else
    echo "Vundle appears to be already installed."
  fi
}

function createDotfileLinks {
  source_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/dotfiles"

  for f in $(ls -A $source_dir)
  do
    dest="$HOME/$(basename $f)"

    if [ ! -f $dest ] && [ ! -h $dest ]; then
      ln -s "$source_dir/$f" $dest 
      echo "$f - linked OK"
    else
      echo "$f - already present (not overwritten)"
    fi
  done
}

installVundleForVimPlugins
createDotfileLinks

#!/bin/bash

function installVundleForVimPlugins {
  vundle_dir=~/.vim/bundle/Vundle.vim
  if [ ! -d "$vundle_dir" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git 
  fi
}

function createDotfileLinks {
  source_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  for f in $(git ls-files | grep ^\\.)
  do
    dest="$HOME/$f"

    if [ ! -f $dest ]; then
      ln -s "$source_dir/$f" $dest 
      echo "$f - linked OK"
    else
      echo "$f - already present (not overwritten)"
    fi
  done
}

installVundleForVimPlugins
createDotfileLinks

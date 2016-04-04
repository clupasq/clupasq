#!/bin/bash

while [[ $# > 0 ]]
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

function installVundleForVimPlugins {
  vundle_dir="$HOME/.vim/bundle/Vundle.vim"
  if [ ! -d "$vundle_dir" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $vundle_dir 
  else
    echo "Vundle appears to be already installed - skipping."
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
      if [[ $OVERWRITE == "Y" ]]; then
        rm -rf $dest
        ln -s "$source_dir/$f" $dest 
        echo "$f - overwritten!"
      else
        echo "$f - already present (not overwritten; use -o to overwrite)"
      fi
    fi
  done
}

installVundleForVimPlugins
createDotfileLinks

#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# detect hidden files
shopt -s dotglob

# symlink dotfiles, skipping directories
for filename in settings/*; do
  if [ ! -d "$filename" ]; then
    ln -fs "$DIR/$filename" "$HOME/$(basename "$filename")"
  fi
done

# symlink sources, skipping directories
for filename in sources/*; do
  if [ ! -d "$filename" ]; then
    ln -fs "$DIR/$filename" "$HOME/$(basename "$filename")"
  fi
done

# special handling for powerline-shell
# copy themes
cp settings/.powerline-shell/* ~/.powerline-shell/

# turn off detect hidden files
shopt -u dotglob

# source profile
source $HOME/.bash_profile

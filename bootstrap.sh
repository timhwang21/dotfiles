#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SUBL_PATH="Library/Application Support/Sublime Text 3"

# detect hidden files
shopt -s dotglob

# symlink dotfiles
for filename in settings/*; do
  ln -fs "$DIR/$filename" "$HOME/$(basename "$filename")"
done

# symlink sources
for filename in sources/*; do
  ln -fs "$DIR/$filename" "$HOME/$(basename "$filename")"
done

# copy sublime package control; will install packages on initial run
cp -i "Package Control.sublime-package" "$HOME/$SUBL_PATH/Installed Packages/Package Control.sublime-package"

# copy sublime settings
for filename in sublime/*; do
  cp -i "$filename" "$HOME/$SUBL_PATH/Packages/User/$(basename "$filename")"
done

# turn off detect hidden files
shopt -u dotglob

# source profile
source $HOME/.bash_profile

#!/bin/bash

# detect hidden files
shopt -s dotglob

# symlink dotfiles
for filename in settings/*; do
  ln -fs "$filename" "$HOME/$(basename "$filename")"
done

# copy sublime settings
for filename in sublime/*; do
  cp -i "$filename" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/$(basename "$filename")"
done

# turn off detect hidden files
shopt -u dotglob

# source profile
source $HOME/.bash_profile
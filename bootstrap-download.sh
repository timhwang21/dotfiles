#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Homebrew
yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install asciinema
brew install bash-completion
brew install ccat
brew install elixir
brew install fasd
brew install fpp
brew install git # override xcode default
brew install git-extras
brew install gnu-sed --with-default-names # installs bin/sed instead of bin/gsed
brew install gnupg
brew install gotop
brew install hub
brew install jq
brew install pandoc
brew install pgcli
brew install postgresql
brew install python # python 3
ln -s /usr/local/bin/python3 /usr/local/bin/python # allow us to type python instead of python3
brew install task
brew install the_silver_searcher
brew install tig
brew install translate-shell
brew install tree
brew install typespeed
brew install vim # override system default
brew install yarn

# gems
gem install pry

# subl symlink -- requires Sublime to be installed
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

# powerline-shell
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
sudo python setup.py install
cd ..
rm -rf powerline-shell

# powerline fonts
brew tap homebrew/cask-fonts
brew cask install font-meslo-nerd-font font-inconsolata-nerd-font

# nvm
mkdir -p ~/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# run regular bootstrap script
./bootstrap.sh

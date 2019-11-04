#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Homebrew
yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install asciinema
brew install bash-completion
brew install bat
brew install elixir
brew install fasd
brew install fpp
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
brew install git # override xcode default
brew install git-extras
brew install gnu-sed --with-default-names # installs bin/sed instead of bin/gsed
brew install gnupg
brew tap cjbassi/gotop
brew install gotop
brew install haskell-stack
brew install hub
brew install jq
brew install --HEAD neovim
brew install pandoc
brew install pgcli
brew install postgresql
brew install python # python 3
ln -s /usr/local/bin/python3 /usr/local/bin/python # allow us to type python instead of python3
brew install source-highlight
brew install task
brew install the_silver_searcher
brew install tig
brew install translate-shell
brew install tree
brew install tmux
brew install typespeed
brew install vim # override system default
brew install yarn

# gems
gem install neovim
gem install neovim-ruby-host
gem install pry
gem install solargraph # ruby language server

# python
python -m pip install --user --upgrade pynvim

# NPM
npm install -g neovim
npm install -g npx

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

# vim plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install coc extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install \
  coc-css \
  coc-elixir \
  coc-eslint \
  coc-git \
  coc-highlight \
  coc-html \
  coc-json \
  coc-lists \
  coc-prettier \
  coc-snippets \
  coc-solargraph \
  coc-svg \
  coc-tslint-plugin \
  coc-tsserver \
  coc-yank \
  --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
cd -

# run regular bootstrap script
./bootstrap.sh

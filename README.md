Dotfiles
=======

![](assets/images/vim.png)
![](assets/images/vim-coc.png)
![](assets/images/vim-fzf-file-search.png)
![](assets/images/vim-fzf-git-log-p.png)
![](assets/images/vim-diff.png)
![](assets/images/fira-code-ligatures.png)
![](assets/images/tig.png)

## Setup

**Note: for personal use. Don't blame me if this screws up your settings.**

```bash
git clone https://github.com/timhwang21/dotfiles.git
cd dotfiles
# Initial setup: install from brew, git, etc.
bin/bootstrap-download
# Install from local files
bin/bootstrap
```

## MacOS Applications

### Essentials

* [1Password](https://1password.com/downloads/mac/)
* [Alfred](https://www.alfredapp.com/)
* [Chrome](https://www.google.com/chrome/)
* [Firefox](https://www.mozilla.org/en-US/firefox/new/)
* [Rectangle](https://rectangleapp.com/) -- tiling manager

### Personal

* Adobe
* Fantastical
* [Discord](https://discord.com/download)
* [Dropbox](https://www.dropbox.com/install)
* [GPG Keychain](https://gpgtools.org/)
* [Spotify](https://www.spotify.com/us/download/mac/)
* [Steam](https://store.steampowered.com/about/download)
* [VLC](https://www.videolan.org/vlc/)

### Work

* [Docker](https://docs.docker.com/desktop/install/mac-install/)
* [Postman](https://www.postman.com/downloads/)
* [Slack](https://slack.com/downloads/mac)

## Other manual steps

## SSH key

```bash
# Personal -- swap with work email when needed
ssh-keygen -t ed25519 -C "timhwang21@gmail.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Follow per-site instructions below
touch ~/.ssh/config
open ~/.ssh/config

# Add to each site's config
# https://github.com/settings/ssh/new
# https://bitbucket.org/account/settings/ssh-keys/
pbcopy < ~/.ssh/id_ed25519.pub

# Test
ssh -T git@github.com
ssh -T git@bitbucket.org
```

`.ssh/config` contents:

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519

Host bitbucket.org
  AddKeysToAgent yes
  IdentityFile ~/.ssh/{ssh-key-name}
```

## Settings

```bash
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15
defaults write -g KeyRepeat -int 1 # normal minimum is 2
```

* Displays > Medium
* Trackpad > Secondary click > Click in Bottom Right Corner
* Trackpad > Natural scrolling off


## TODO

### LaTeX

Needed for Pandoc PDF export.

```sh
# first install BasicTeX - http://www.tug.org/mactex/morepackages.html
sudo tlmgr update --self
sudo tlmgr install collection-fontsrecommended
```

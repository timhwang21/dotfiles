Dotfiles
=======

## Setup

**Note: for personal use. Don't blame me if this screws up your settings.**

```bash
git clone https://github.com/timhwang21/dotfiles.git
cd dotfiles
# Initial setup: install from brew, git, etc.
chmod +x bootstrap-download.sh
sh bootstrap-download.sh
# Install from local files
chmod +x bootstrap.sh
sh bootstrap.sh
```

## MacOS Applications

* 2do
* Adobe
* Alfred 3 (not 2, from app store)
* Chrome
* Discord
* Divvy
* Docker
* Dropbox
* Fantastical
* Firefox
* GIPHY Capture
* GPG Keychain
* iTerm
* Lastpass
* Postman
* Slack
* Spotify
* Steam
* Sublime Text 3
* VLC

## TODO

### LaTeX

Needed for Pandoc PDF export.

```sh
# first install BasicTeX - http://www.tug.org/mactex/morepackages.html
sudo tlmgr update --self
sudo tlmgr install collection-fontsrecommended
```

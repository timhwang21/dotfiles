#!/usr/bin/env bash

###########################
##                       ##
##     A L I A S E S     ##
##                       ##
###########################

# =========================
#  1. shell
# =========================
#  1a. ls
# -------------------------
alias ls="ls -AFGlh"

#  1b. cd
# -------------------------
alias ..="cl .." # step back 1 level
alias ...="cl ../.." # step back 2 levels
alias b="cd -" # back button
function cl() { cd "$@" && ls; }
function md() { mkdir -p "$@" && cd "$_"; }

#  1c. idiot-proofing overwrites
# -------------------------
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

#  1d. CLI management
# -------------------------
alias reload="source $HOME/.bash_profile"

alias r="reload"

#  1e. information
# -------------------------
function h() { history | grep "$@" --color=always; }
function ch() { history | awk '{ count[$2]++ } END { for (cmd in count) { print count[cmd] " " cmd } }' | sort -rn | head -20; }
alias t="gotop"

#  1f. desktop
# -------------------------

#  1g. emoji
# -------------------------
function copyemoji() { echo "$1" | pbcopy | echo "$2 $1"; }
alias supson="copyemoji \"¯\_(ツ)_/¯\" \"READY TO SHRUG\""
alias tableflip="copyemoji \"(╯°□°）╯︵ ┻━┻\" \"READY TO TABLEFLIP\""

# ========================
#  2. package manager
# ========================
#  2a. rails
# -------------------------
alias be="bundle exec"
alias ber="bundle exec rspec"
alias bi="bundle install"

#  2b. npm
# -------------------------
alias ni="npm install"
alias nig="npm install -g"
function nis() { npm install "$@" --save; }
function nisd() { npm install "$@" --save-dev; }
alias ya="yarn add"
alias yad="yarn add -D"

#  2c. update all
# -------------------------
alias update_all="bundle update && npm update -g && brew update && brew upgrade `brew outdated`"

# ========================
#  3. git
# ========================
alias git="hub" # requires Hub to work -- brew install hub
alias gi="git init"

#  3a. adding & committing
# -------------------------
alias ga="git add -A"
alias gc="git commit"
function gacm() { ga && gcm "$@"; }
function gcm() { git commit -m "$@" --no-verify; }
function greb() { git rebase -i HEAD~"$@"; }
alias clean="git clean -id"
alias amend="git commit --amend --no-verify"
alias amendv="git commit --amend"
function replace() { git grep -l $1 | xargs sed -i "" -e "s/$1/$2/g"; }
alias recommit="git commit -C HEAD@{1} --no-verify"

#  3b. branch mgmt
# -------------------------
alias gb="git branch -v | cat"
function gcb() { git checkout -b devs/$USER/"$@"; } # make new branch with just ticket name -- eg. 'gcb ORION-699'
function _fuzzybranch() { git branch | grep -m 1 "$@" | tr -d "* "; } # fuzzy match branch names
function gch() { _fuzzybranch "$@" | xargs git checkout; } # quick git checkout for long branch names
function gbd() { _fuzzybranch "$@" | xargs git branch -D; gb; } # quick delete -- careful, this fuzzy matches
function gdiff() { _fuzzybranch "$@" | xargs git rev-parse | xargs git diff HEAD..; } # difference between head and branch
alias gd="git diff master..."
alias gch-="git checkout -"
alias changed="git diff --name-only"
alias openchanged="$GUI_EDITOR -p . | changed | xargs $GUI_EDITOR"
alias gch--.="git checkout -- ." # reset local changes on branch
alias gm="git merge --no-ff"

#  3c. pulling
# -------------------------
alias gcl="git clone"
alias gpull="git pull --rebase"
alias gr="git rebase"
alias grom="git rebase origin/master"
alias cont="git rebase --continue"
alias abort="git rebase --abort"

#  3d. pushing
# -------------------------
alias gp="git push"
alias gpom="git push origin master"

#  3e. information
# -------------------------
alias gs="git status"
alias gr="git remote -v"

# ========================
#  4. docker
# ========================
alias dc="docker-compose"

# ========================
#  5. config
# ========================
alias .sublp="open -a Finder ~/Library/Application\ Support/Sublime\ Text\ 3/Packages"

# ========================
#  6. db
# ========================

# ========================
#  7. heroku
# ========================
alias hlog="heroku login"
alias ho="heroku open"
alias hr="heroku run"
alias hl="heroku local"
alias ha="heroku addons"
alias hac="heroku addons:create"

# ========================
#  8. watchers
# ========================
alias ww="webpack --watch"
alias sw="sass --watch"

# ========================
#  9. Java
# ========================
# function jc() { javac "$@".java && java "$@"; }

# ========================
#  10. Editor
# ========================
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# ========================
#  #. Other Utilities
# ========================
function weather() { clear; curl "wttr.in/$@?m"; }
alias dl="curl -O# -C - --retry 3"
alias vjq="jq '.' | $EDITOR - -c 'set ft=json'"
alias rec="asciinema rec --command=\"/bin/bash -l\" --idle-time-limit=2"
alias cat="ccat" # colorized cat

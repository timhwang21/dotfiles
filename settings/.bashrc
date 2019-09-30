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
function cl() { cd "$@" && ls; }

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
alias disapproval="copyemoji \"ಠ_ಠ\" \"LOOK OF DISAPPROVAL\""

# ========================
#  2. package manager
# ========================
#  2a. rails
# -------------------------
alias be="bundle exec"
alias ber="bundle exec rspec"
alias bi="bundle install"

#  2b. UNUSED
# -------------------------

#  2c. update all
# -------------------------
alias update_all="bundle update && npm update -g && brew update && brew upgrade `brew outdated`"

# ========================
#  3. git
# ========================
alias git="hub" # requires Hub to work -- brew install hub
alias delete-pruned="git branch --merged master | grep -v \"\* master\" | xargs -n 1 git branch -d"

#  3a. adding & committing
# -------------------------
alias ga="git add -A"
alias gc="git commit"
function gacm() { ga && gcm "$@"; }
function gcm() { git commit -m "$@"; }
function greb() { git rebase -i HEAD~"$@"; }
alias clean="git clean -id"
alias amend="git commit --amend"
alias recommit="git commit -C HEAD@{1}"

#  3b. branch mgmt
# -------------------------
alias gb="git branch -v | cat"
function gcb() { git checkout -b $USER/"$@"; } # make new branch with just ticket name -- eg. 'gcb ORION-699'
function _fuzzybranch() { git branch | grep -m 1 "$@" | tr -d "* "; } # fuzzy match branch names
function gch() { _fuzzybranch "$@" | xargs git checkout; } # quick git checkout for long branch names
function gbd() { _fuzzybranch "$@" | xargs git branch -D; gb; } # quick delete -- careful, this fuzzy matches
function gdiff() { _fuzzybranch "$@" | xargs git rev-parse | xargs git diff HEAD..; } # difference between head and branch
alias gd="git diff master..."
alias gch-="git checkout -"
alias changed="git diff --name-only"
alias changed-commit="git diff-tree --no-commit-id --name-only -r"
alias openchanged='$EDITOR -p `changed`'
alias gch--.="git checkout -- ." # reset local changes on branch

#  3c. pulling
# -------------------------
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
#  5. less
# ========================
alias less='less -m -N -g -i -J --underline-special --SILENT'

# ========================
#  6. UNUSED
# ========================

# ========================
#  7. UNUSED
# ========================

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
alias rec="asciinema rec --command=\"/bin/bash -l\" --idle-time-limit=1"
alias cat="bat" # colorized cat

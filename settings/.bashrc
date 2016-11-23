#!/usr/bin/env bash

###########################
##                       ##
##     A L I A S E S     ##
##                       ##
###########################

# =========================
#  1. shell
# =========================
#  1a. cd
# -------------------------
alias ..="cl .." # step back 1 level
alias ...="cl ../.." # step back 2 levels
alias back="cd -" # back button
function cl() { cd "$@" && ls; }
function md() { mkdir -p "$@" && cd "$_"; }

#  1b. ls
# -------------------------
alias .ls="ls -d .*" # show hidden files
alias ls="ls -Gp"

#  1c. idiot-proofing overwrites
# -------------------------
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

#  1d. CLI management
# -------------------------
alias reload="source $HOME/.bash_profile"

alias c="clear"
alias r="reload"
alias s="subl"

#  1e. information
# -------------------------
function h() { history | grep "$@" --color=always; }
function ch() { history | awk '{ count[$2]++ } END { for (cmd in count) { print count[cmd] " " cmd } }' | sort -rn | head -20; }
alias t="top -F -n 10 -R -s 2 -u -stats cpu,mem,pid,command,time"

#  1f. desktop
# -------------------------
function appmode() { /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="$@"; }
alias f="open -a Finder ./"

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

#  2c. update all
# -------------------------
alias update_all="bundle update && npm update -g && brew update && brew upgrade `brew outdated`"

# ========================
#  3. git
# ========================
alias git="hub" # requires Hub to work -- brew install hub
alias gi="git init"
alias gh="git remote -v | grep fetch | awk '{print $2}' | sed 's/\.git//' | head -n1 | xargs open"

#  3a. adding & committing
# -------------------------
alias ga="git add -A"
alias gap="git add -A -p"
alias gc="git commit"
alias amend="git commit --amend"
alias gcm="git commit -m"
alias recommit="git commit -C HEAD@{1}"
function gacm() { ga && gcm "$@"; }
function greb() { git rebase -i HEAD~"$@"; }

#  3b. branch mgmt
# -------------------------
alias gb="git branch -v | grep -ve '  WIP/'" # more informative git branch
alias gball="git branch -v" # show all
function fuzzybranch() { git branch | grep -m 1 "$@" | tr -d "* "; } # fuzzy match branch names
function gcb() { git checkout -b devs/$USER/"$@"; } # make new branch with just ticket name -- eg. 'gcb ORION-699'
function gch() { fuzzybranch "$@" | xargs git checkout; } # quick git checkout for long branch names
function gbd() { fuzzybranch "$@" | xargs git branch -D; } # quick delete -- careful, this fuzzy matches
function gdiff() { fuzzybranch "$@" | xargs git rev-parse | xargs git diff HEAD..; } # difference between head and branch
alias gd="git diff master..."
alias gch-="git checkout -"
alias changed="git diff --name-status master... | cat"
alias openchanged="subl -n . | changed | grep '^[AM]' | sed -e 's/^[AM]//' | xargs subl"
alias gch--.="git checkout -- ." # reset local changes on branch
alias gm="git merge --no-ff"

#  3c. pulling
# -------------------------
alias gcl="git clone"
alias gpull="git pull --rebase"
alias grom="git rebase origin/master"
alias gtool="git mergetool"
alias cont="git rebase --continue"
alias abort="git rebase --abort"

#  3d. pushing
# -------------------------
alias gpush="git push"
alias gp="gpush"
alias gphm="git push heroku master"
alias gpom="git push origin master"

#  3e. information
# -------------------------
alias gl="git log --pretty=oneline --abbrev-commit -n 20"
alias glog="tig"
alias gs="git status"
alias gr="git remote"

# ========================
#  4. docker
# ========================
alias dc="docker-compose"

# ========================
#  5. config
# ========================
alias .brc="subl $HOME/.bashrc"
alias .bp="subl $HOME/.bash_profile"
alias .sublp="open -a Finder ./Library/Application\ Support/Sublime\ Text\ 3/Packages"

# ========================
#  6. rails
# ========================
alias testmigrate="bundle exec rake db:migrate db:test:load"

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
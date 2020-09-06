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
alias ls="exa --icons -laF"

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
alias t="ytop"

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

#  3a. adding & committing
# -------------------------
alias ga="git add -A"
alias gc="git commit"
alias gb="git --no-pager branch"
function gacm() { ga && gcm "$@"; }
function gcm() { git commit -m "$@"; }
function greb() { git rebase -i HEAD~"$@"; }
alias clean="git clean -id"
alias recommit="git commit -C HEAD@{1}"

#  3b. branch mgmt
# -------------------------
function gcb() { git checkout -b $USER/"$@"; } # make new branch with just ticket name -- eg. 'gcb ORION-699'
function _fuzzybranch() { git branch | grep -m 1 "$@" | tr -d "* "; } # fuzzy match branch names
alias gd="git diff master..."
alias changed-commit="git diff-tree --no-commit-id --name-only -r"
alias changed="git diff --name-only origin/master"
alias openchanged='$EDITOR -p `changed`'
alias gch--.="git checkout -- ." # reset local changes on branch
alias delete-pruned="git branch --merged master | grep -v \"\* master\" | xargs -n 1 git branch -d"
# gch - fzf git checkout
# checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
function gch() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf -0 -1 -q "$1" +m --height 40% --no-hscroll -n 1 --ansi --preview="git --no-pager log -150 --stat --pretty=format:%s '..{2}'") &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# gbd - fzf git branch delete
function gbd() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf -0 -1 -q "$1" +m --height 40% --no-hscroll -n 1 --ansi --preview="git --no-pager log -150 --stat --pretty=format:%s '..{2}'") &&
  git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

#  3c. pulling
# -------------------------
alias gr="git rebase"
alias grom="git fetch && git rebase origin/master"
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

# Runs a command in a container
function dc-run() {
  local service command
  service=$(docker-compose ps -a --services | fzf -0 -1 -q "$1" +m --height 40% --no-preview --ansi)
  command=${2:-/bin/bash}

  [ -n "$service" ] && docker-compose run --rm "$service" "$command"
}

function dc-logs() {
  local service tail
  service=$(docker-compose ps -a --services | fzf -0 -1 -q "$1" +m --height 40% --no-preview --ansi)
  tail=${2:-200}

  [ -n "$service" ] && docker-compose logs --tail="$tail" -f "$service"
}

# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -0 -1 -q "$1" +m --height 40% --no-preview --ansi | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -0 -1 -q "$1" -m --height 40% --no-preview --ansi | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -0 -1 -q "$1" -m --height 40% --no-preview --ansi | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# ========================
#  5. less
# ========================
alias less='less -m -N -g -i -J --underline-special --SILENT'

# ========================
#  6. fzf
# ========================
#
# https://github.com/junegunn/fzf/wiki/Examples
# 
# fe - fzf edit
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
# Add fasd on top of this for frecency
function fe() {
  IFS=$'\n' files=($(fzf -0 -1 -q "$1" -m --ansi))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# ========================
#  7. UNUSED
# ========================

# ========================
#  8. watchers
# ========================

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
function dlm3u8() { ffmpeg -i "$1" -bsf:a aac_adtstoasc -c copy -vcodec copy -crf 30 "$2.mp4"; }

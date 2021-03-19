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

#  1b. dir
# -------------------------
alias ..="cl .." # step back 1 level
alias ...="cl ../.." # step back 2 levels
function cl() { cd "$@" && ls; }
alias mkdir="mkdir -p" # create intermediary dirs

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
alias gd="git diff origin/master..."
alias changed="git --no-pager diff --name-only origin/master"
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

# 3f. patch git-extras
# https://github.com/tj/git-extras/blob/master/bin/git-summary
# -------------------------
function _git_dedup_by_email() {
    LC_ALL=C awk '
    {
        sum += $1
        if ($NF in emails) {
            emails[$NF] += $1
        } else {
            email = $NF
            emails[email] = $1
            # set commits/email to empty
            $1=$NF=""
            sub(/^[[:space:]]+/, "", $0)
            sub(/[[:space:]]+$/, "", $0)
            name = $0
            if (name in names) {
                # when the same name is associated with existed email,
                # merge the previous email into the later one.
                emails[email] += emails[names[name]]
                emails[names[name]] = 0
            }
            names[name] = email
        }
    }
    END {
        for (name in names) {
            email = names[name]
            printf "%6d\t%s\n", emails[email], name
        }
    }' | sort -rn -k 1
}
function _git_format_authors() {
  # a rare unicode character is used as separator to avoid conflicting with
  # author name. However, Linux column utility will escape tab if separator
  # specified, so we do unesaping after it.
  LC_ALL=C awk '
  { args[NR] = $0; sum += $0 }
  END {
    for (i = 1; i <= NR; ++i) {
      printf "%s♪%2.1f%%\n", args[i], 100 * args[i] / sum
    }
  }
  ' | column -t -s♪ | sed "s/\\\x09/\t/g"
}

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

#!/usr/bin/env zsh

# allow inline comments
setopt interactivecomments

# Reset config on re-source
source /etc/profile

# Secrets
[ -f ~/.secrets ] && source ~/.secrets

###########################
##                       ##
##       P A T H S       ##
##                       ##
###########################

# Home
# -------------------------
export PATH="$HOME/.local/bin:$PATH"

# !!!!!!!!!!!!!!!!!!!!!!!!!
# Do not put any PATH changes after this!
# !!!!!!!!!!!!!!!!!!!!!!!!!

###########################
##                       ##
##      C O N F I G      ##
##                       ##
###########################

# -------------------------
export EDITOR='nvim'
export GUI_EDITOR='code'

#  grep colorize
# -------------------------
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='37;41'

#  history
# -------------------------
export HISTSIZE=10000 # default 500
export HISTFILESIZE=10000 # default 500

#  node
# -------------------------
# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

#  gpg
# -------------------------
export GPG_TTY=$(tty)

#  Enable key repeat
# -------------------------
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# speed up past what system preferences allows
defaults write -g KeyRepeat -int 1

#  Better manpage colors
# -------------------------
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#  bat
# -------------------------
export BAT_THEME="Monokai Extended Origin"

###########################
##                       ##
##    D O T F I L E S    ##
##                       ##
###########################

#  Home or work machine
# -------------------------
# Uncomment the appropriate line
# [[ -f $HOME/.zshrc.home ]] && . $HOME/.zshrc.home
[[ -f $HOME/.zshrc.work ]] && . $HOME/.zshrc.work

#  Colorize prompt & less
# -------------------------
export LESSOPEN="| $(brew --prefix)/bin/src-hilite-lesspipe.sh %s"
export LESS="--RAW-CONTROL-CHARS -RS#3NM~g" # allow colorize and line numbers
# Enable italics in tmux
export TERM=xterm-256color-italic

#  zoxide
# -------------------------
[[ -f $(brew --prefix)/bin/zoxide ]] && eval "$(zoxide init zsh)" || echo "\"zoxide\" not installed. Is it there?"

#  starship
# -------------------------
eval "$(starship init zsh)"

#  fzf
# -------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use rg as default find command
export FZF_DEFAULT_COMMAND='rg --files --hidden'
# NOTE: Not recommended to add --preview to FZF default options
export FZF_DEFAULT_OPTS='--inline-info --multi --reverse'

#  version managers
# -------------------------
[ -f $(brew --prefix asdf)/libexec/asdf.sh ] && . $(brew --prefix)/opt/asdf/libexec/asdf.sh

###########################
##                       ##
##     A L I A S E S     ##
##                       ##
###########################

# =========================
#  shell
# =========================
alias ls="eza --icons -laF $@"
alias ..="cd .." # step back 1 level
alias mkdir="mkdir -p" # create intermediary dirs
alias icat="kitty +kitten icat"

#  idiot-proofing overwrites
# -------------------------
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

#  CLI management
# -------------------------
alias reload="exec zsh"
alias r="reload"

#  adding & committing
# -------------------------
alias ga="git add -A"
alias gc="git commit"
alias gam="git amend"
function gacm() { ga && gcm "$@"; }
function gcm() { git commit -m "$@"; }
function greb() { git rebase -i HEAD~"$@"; }
alias clean="git clean -id"
alias recommit="git commit -C HEAD@{1}"

#  branch mgmt
# -------------------------
function gcb() { git checkout -b $USER/"$@"; } # make new branch with just ticket name -- eg. 'gcb ORION-699'
alias _gmainbranch="git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"
alias gch--.="git checkout -- ." # reset local changes on branch
function deletepruned() {
  local mainbranch=$(_gmainbranch)
  git branch --merged "$mainbranch" | grep -v "* $mainbranch" | xargs -n 1 git branch -d
}
alias gb="git --no-pager branch -vv"
# gl - fzf git log
function gl() {
  local commits sha
  commits=$(git --no-pager log "${1:-HEAD}" --max-count=1000 --pretty=format:"%h%x09%an%x09%s") &&
  sha=$(echo "$commits" | fzf --no-multi --no-hscroll --ansi --preview-window=up,60% --preview="git --no-pager show --compact-summary {1} | bat --style=numbers --color=always --line-range=:100") &&
  # echo "$sha"
  echo "$sha" | awk '{print $1}'
}
# FZF git branch
function _gbr() {
  local branch
  branch=$(echo "$(gb -a)" | fzf --exit-0 --select-1 --query="$1 !^remotes" --no-multi --height 35% --no-hscroll --nth=1 --ansi --preview="git --no-pager log -150 --compact-summary --pretty=format:%s '..{2}'") &&
  echo "$branch" | sed "s/^*//" | awk '{print $1}' | sed "s/.* //"
}
# Check out the selected branch
function gch() {
  local branch
  branch=$(_gbr "$1")
  [[ ! -z "$branch" ]] && git checkout "$branch"
}
# Delete the selected branch
function gbd() {
  local branch
  branch=$(_gbr "$1")
  [[ ! -z "$branch" ]] && git branch -D "$branch"
}
# Diff the selected branch against the current branch
function gd() {
  local branch
  branch=$(_gbr "$1")
  [[ ! -z "$branch" ]] && git diff "$branch"...
}
function changed() {
  local branch
  branch=$(_gbr "$1")
  [[ ! -z "$branch" ]] && git --no-pager diff --name-only "$branch"...
}

#  pulling
# -------------------------
alias gr="git rebase"
function grom() {
  local mainbranch=$(_gmainbranch)
  git fetch && git rebase origin/"$mainbranch"
}
alias cont="git rebase --continue"
alias abort="git rebase --abort"

#  pushing
# -------------------------
alias gp="git push"

#  information
# -------------------------
alias gs="git status"
alias gr="git remote -v"

#  patch git-extras
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
#  docker
# ========================
alias dc="docker compose"

# Runs a command in a container
function dc-run() {
  local service command
  service=$(docker compose ps -a --services | fzf --exit-0 --select-1 --query="$1" --no-multi --height 40% --no-preview --ansi)
  command=${2:-/bin/bash}

  [ -n "$service" ] && docker compose run --rm "$service" "$command"
}

function dc-stop() {
  local service
  service=$(docker compose ps -a --services | fzf --exit-0 --select-1 --query="$1" --multi --height 40% --no-preview --ansi)

  [ -n "$service" ] && docker compose stop "$service"
}

function dc-logs() {
  local service tail
  service=$(docker compose ps -a --services | fzf --exit-0 --select-1 --query="$1" --multi --height 40% --no-preview --ansi)
  tail=${2:-200}

  [ -n "$service" ] && docker compose logs --tail="$tail" -f "$service"
}

# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf --exit-0 --select-1 --query="$1" --no-multi --height 40% --no-preview --ansi | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf --exit-0 --select-1 --query="$1" --multi --height 40% --no-preview --ansi | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf --exit-0 --select-1 --query="$1" --multi --height 40% --no-preview --ansi | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# ========================
#  less
# ========================
alias less='less -m -N -g -i -J --underline-special --SILENT'

# ========================
#  fzf
# ========================
#
# https://github.com/junegunn/fzf/wiki/Examples
# 
# e -- edit
# e [FUZZY PATTERN] - Open the selected file with the default editor
function e() {
  IFS=$'\n' files=($(fzf --exit-0 --select-1 --query="$1" --multi --ansi --preview="bat --style=numbers --color=always --line-range=:100 {1}"))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# ========================
#  Editor
# ========================
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# ========================
#  Other Utilities
# ========================
function weather() { clear; curl "wttr.in/$@?m"; }
alias dl="curl -O# -C - --retry 3"
alias rec="asciinema rec --command=\"/bin/zsh -l\" --idle-time-limit=1"
function dlm3u8() {
  ffmpeg -i "$1" -bsf:a aac_adtstoasc -c copy -vcodec copy -crf 30 "$(date +%s).mp4";
}

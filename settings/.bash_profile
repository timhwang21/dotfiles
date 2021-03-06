#!/usr/bin/env bash

# Reset config on re-source
source /etc/profile

# Secrets
[ -f ~/.secrets ] && source ~/.secrets

###########################
##                       ##
##      C O N F I G      ##
##                       ##
###########################

# -------------------------
export EDITOR='nvim'
export GUI_EDITOR='code'
set -o vi # use vim mode for editing prev commands

#  grep colorize
# -------------------------
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='37;41'

#  bash history
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
[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc
# Uncomment the appropriate line
[[ -f $HOME/.bashrc.home ]] && . $HOME/.bashrc.home
# [[ -f $HOME/.bashrc.work ]] && . $HOME/.bashrc.work

#  Colorize prompt & less
# -------------------------
export LESSOPEN="| $(brew --prefix)/bin/src-hilite-lesspipe.sh %s"
export LESS="--RAW-CONTROL-CHARS -RS#3NM~g" # allow colorize and line numbers
[[ -f $HOME/.LESS_TERMCAP ]] && . $HOME/.LESS_TERMCAP || echo "\".LESS_TERMCAP\" not found. Is it there?"
[[ -f $HOME/.COLORIZE_PROMPT ]] && . $HOME/.COLORIZE_PROMPT || echo "\".COLORIZE_PROMPT\" not found. Is it there?"
# Enable italics in tmux
export TERM=xterm-256color-italic

#  Bash completion
# -------------------------
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion || echo "\"bash_completion\" not installed. Is it there?"

#  npm & yarn completion
# -------------------------
[[ -f $HOME/.npm-completion.bash ]] && . $HOME/.npm-completion.bash || echo "\".npm-completion\" not found. Is it there?"
[[ -f $HOME/.yarn-completion.bash ]] && . $HOME/.yarn-completion.bash || echo "\".yarn-completion\" not found. Is it there?"

# Git completion
# -------------------------
[[ -f ~/.git-completion.bash ]] && . $HOME/.git-completion.bash || echo "\".git-completion\" not found. Is it there?"

#  fasd
# -------------------------
[[ -f $(brew --prefix)/bin/fasd ]] && eval "$(fasd --init auto)" || echo "\"fasd\" not installed. Is it there?"

#  powerline-shell
# -------------------------
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#  fzf
# -------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Use rg as default find command
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--inline-info --multi --reverse --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500"'Aa

###########################
##                       ##
##       P A T H S       ##
##                       ##
###########################

#  Homebrew sbin
# -------------------------
export PATH="$HOME/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

#  Java
# -------------------------
export JAVA_HOME="/usr/libexec/java_home"

#  Node & NVM
# -------------------------
export PATH="/usr/local/lib/node_modules:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"
# NOTE: nvm doesn't support brew, if things go south ininstall and use curl script
# NOTE 2: The `use stable` is a no-op most of the time but helps sublime linter find eslint
# Recommended config
export NVM_DIR="$HOME/.nvm"
[[ -f "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -f "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
# Homebrew config
[[ -f $(brew --prefix)/opt/nvm/nvm.sh ]] && . $(brew --prefix)/opt/nvm/nvm.sh
[[ -f $(brew --prefix)/opt/nvm/bash_completion ]] && . $(brew --prefix)/opt/nvm/bash_completion

# Home
# -------------------------
export PATH="$HOME/.local/bin:$PATH"

# Yarn
# -------------------------
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#  Python
# -------------------------
export PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"

#  Chrome
# -------------------------
export PATH="/usr/local/Cellar/chromedriver:$PATH"

#  Haskell
# -------------------------
export PATH="$HOME/Library/Haskell/bin:$PATH"

#  Go
# -------------------------
export PATH="$HOME/go/bin:$PATH"

#  Google App Engine
# -------------------------
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then source "$HOME/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then source "$HOME/google-cloud-sdk/completion.bash.inc"; fi

# !!!!!!!!!!!!!!!!!!!!!!!!!
# Do not put any PATH changes after this!
# !!!!!!!!!!!!!!!!!!!!!!!!!

#  rvm
# -------------------------
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


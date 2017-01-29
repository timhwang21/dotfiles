#!/usr/bin/env bash

###########################
##                       ##
##      C O N F I G      ##
##                       ##
###########################

#  make sublime be my default editor; -w flag keeps subl open til Sublime window is closed
# -------------------------
export EDITOR='subl -w'

###########################
##                       ##
##    D O T F I L E S    ##
##                       ##
###########################

#  Home or work machine
# -------------------------
[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc
# [[ -f $HOME/.bashrc.home ]] && . $HOME/.bashrc.home
[[ -f $HOME/.bashrc.work ]] && . $HOME/.bashrc.work

#  iTerm2 shell integration
# -------------------------
[[ -f $HOME/.iterm2_shell_integration.bash ]] && . $HOME/.iterm2_shell_integration.bash || echo "\".iterm2_shell_integration\" not found. Is it there?"

#  Colorize prompt & less
# -------------------------
export LESS="--RAW-CONTROL-CHARS -RS#3NM~g" # allow colorize and line numbers
[[ -f $HOME/.LESS_TERMCAP ]] && . $HOME/.LESS_TERMCAP || echo "\".LESS_TERMCAP\" not found. Is it there?"
[[ -f $HOME/.COLORIZE_PROMPT ]] && . $HOME/.COLORIZE_PROMPT || echo "\".COLORIZE_PROMPT\" not found. Is it there?"

#  Bash completion
# -------------------------
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion || echo "\"bash_completion\" not installed. Is it there?"

#  rupa.z
# -------------------------
[[ -f $(brew --prefix)/bin/z.sh ]] && . $(brew --prefix)/bin/z.sh || echo "\"z.sh\" not installed. Is it there?"

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
[[ -f $(brew --prefix)/opt/nvm/nvm.sh ]] && . $(brew --prefix)/opt/nvm/nvm.sh

#  Postgres
# -------------------------
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export POSTGRES="/Applications/Postgres.app/Contents/Versions/latest/bin"

#  Python
# -------------------------
export PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"

#  Rbenv
# -------------------------
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
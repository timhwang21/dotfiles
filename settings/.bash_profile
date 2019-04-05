#!/usr/bin/env bash

# Reset config on re-source
source /etc/profile

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
# [[ -f $(brew --prefix)/bin/z.sh ]] && . $(brew --prefix)/bin/z.sh || echo "\"z.sh\" not installed. Is it there?"

#  Testing how this compares with rupa/z
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

#  Python
# -------------------------
export PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:${PATH}"

#  Chrome
# -------------------------
export PATH="/usr/local/Cellar/chromedriver:$PATH"

#  Rbenv
# -------------------------
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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

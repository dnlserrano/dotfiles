# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Default username
DEFAULT_USER=dnlserrano

# Disable automatic renaming of shell
DISABLE_AUTO_TITLE=true

# Set theme
ZSH_THEME="agnoster"

# oh-my-zsh plugins
plugins=(git)

# User configuration
source $ZSH/oh-my-zsh.sh
export PATH=$PATH:"/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin"

# RVM
source $HOME/.rvm/scripts/rvm
export PATH="$PATH:/usr/local/rvm/bin"

# Navigation
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# npm
export NPM_PACKAGES=$HOME/.npm-packages
export NODE_PATH=$NPM_PACKAGES/lib/node_modules
export PATH=$PATH:$NPM_PACKAGES/bin

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# golang
export GOPATH=$HOME/Workspace/go # Add GOPATH
export PATH=$PATH:$GOPATH/bin

# Docker
export PATH=$PATH:$HOME/.docker

# Dinghy
if which dinghy >/dev/null; then
  eval $(dinghy env)
fi

# Aliases
source $HOME/.dotfiles/aliases

# AWS EB Client
export PATH=$PATH:$HOME/Library/Python/2.7/bin

# Editor
export EDITOR=vim

# less
export LESS=-X

# fzf
setopt HIST_IGNORE_ALL_DUPS
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# awscli
if [ -d $HOME/.awscli ]; then
  source $HOME/.awscli/bin/aws_zsh_completer.sh
  PATH=$PATH:$HOME/.awscli/bin
fi

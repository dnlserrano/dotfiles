# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Default username
DEFAULT_USER=dnlserrano

# Disable automatic renaming of shell
DISABLE_AUTO_TITLE=true

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# golang
export GOPATH=$HOME/Workspace/go # Add GOPATH
export PATH=$PATH:$GOPATH/bin

# Docker
export PATH=$PATH:~/.docker

# Dinghy
eval $(dinghy env)
export DOCKER_HOST=tcp://192.168.64.5:2376
export DOCKER_CERT_PATH=/Users/dnlserrano/.docker/machine/machines/dinghy
export DOCKER_TLS_VERIFY=1
export DOCKER_MACHINE_NAME=dinghy

# Aliases
source ~/.dotfiles/aliases

# Editor
export EDITOR=vim

# Autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# less
export LESS=-X

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

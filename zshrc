# Path to oh-my-zsh installation
export DOTFILES=$HOME/dotfiles
export ZSH=$HOME/.oh-my-zsh

# Default username
DEFAULT_USER=dnlserrano

# Disable automatic renaming of shell
DISABLE_AUTO_TITLE=true

# Set theme
ZSH_THEME="punctual"

# oh-my-zsh plugins
plugins=(git)

# User configuration
source $ZSH/oh-my-zsh.sh
export PATH=$PATH:"/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin"

# Navigation
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Docker
export PATH=$PATH:$HOME/.docker

# Aliases
source $DOTFILES/aliases

# Company stuff
source $HOME/.company

# Editor
export EDITOR=vim

# less
export LESS=-X

# char encoding
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# fzf
setopt HIST_IGNORE_ALL_DUPS
export FZF_DEFAULT_COMMAND='rg --files --hidden'
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
source $DOTFILES/scripts/fzf.sh

# fubectl
[ -f $HOME/.kube/fubectl.source ] && source $HOME/.kube/fubectl.source

# awscli
if [ -d $HOME/.awscli ]; then
  source $HOME/.awscli/bin/aws_zsh_completer.sh
  PATH=$PATH:$HOME/.awscli/bin
fi

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# rust
export PATH=$PATH:$HOME/.cargo/bin

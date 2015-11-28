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
export PATH=$PATH:"~/.rvm/gems/ruby-2.2.1/bin:~/.rvm/gems/ruby-2.2.1@global/bin:~/.rvm/rubies/ruby-2.2.1/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:~/.rvm/bin:/usr/local/opt/android-sdk-r24.1.2/platform-tools:~/.node/bin:~/Workspace/go/bin:~/.dotfiles/scripts"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# RVM
source $HOME/.rvm/scripts/rvm

# Android SDK
export PATH="$PATH:/usr/local/opt/android-sdk-r24.1.2/platform-tools" # Add Android SDK to PATH

# Navigation
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# npm
export PATH="$PATH:$HOME/.node/bin" # Add NPM to PATH

# golang
export GOPATH=$HOME/Workspace/go # Add GOPATH
export PATH=$PATH:$GOPATH/bin

# Aliases
source ~/.dotfiles/aliases

# Editor
export EDITOR=vim

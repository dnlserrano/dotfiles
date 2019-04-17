DOTFILES=~/.dotfiles

# tmux
ln -s $DOTFILES/tmux.conf ~/.tmux.conf

# zsh
ln -s $DOTFILES/zshrc ~/.zshrc

# vim
ln -s $DOTFILES/vimrc ~/.vimrc

mkdir -p ~/.vim/colors
ln -s $DOTFILES/vim/colors/solarized.vim ~/.vim/colors/solarized.vim

# git
ln -s $DOTFILES/git/gitconfig ~/.gitconfig

mkdir -p ~/.git/git-templates/hooks
ln -s $DOTFILES/git/git-templates/hooks/prepare-commit-msg ~/.git/git-templates/hooks/prepare-commit-msg

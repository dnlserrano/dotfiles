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

COMMIT_HOOK=$DOTFILES/git/git-templates/hooks/prepare-commit-msg
mkdir -p ~/.git-templates/hooks
ln -s $COMMIT_HOOK ~/.git-templates/hooks/prepare-commit-msg
chmod +x $COMMIT_HOOK

# oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/themes
ln -s $DOTFILES/oh-my-zsh/custom/themes/punctual.zsh-theme ~/.oh-my-zsh/custom/themes/

#!/usr/bin/env bash
# Link Mac dotfiles into $HOME. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    printf 'skip %s (already exists)\n' "$dst"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  printf 'linked %s -> %s\n' "$dst" "$src"
}

link "$DOTFILES" "$HOME/.dotfiles"
if [ "$(readlink "$HOME/.dotfiles" 2>/dev/null || true)" != "$DOTFILES" ]; then
  printf 'warning: ~/.dotfiles does not point at %s; export DOTFILES manually\n' "$DOTFILES" >&2
fi

link "$DOTFILES/mac/tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES/mac/zshrc" "$HOME/.zshrc"
link "$DOTFILES/mac/vimrc" "$HOME/.vimrc"
link "$DOTFILES/mac/aliases" "$HOME/.aliases"
link "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/git/gitignore" "$HOME/.gitignore"

chmod +x "$DOTFILES/git/git-templates/hooks/prepare-commit-msg"
link "$DOTFILES/git/git-templates/hooks/prepare-commit-msg" \
  "$HOME/.git-templates/hooks/prepare-commit-msg"

mkdir -p "$HOME/.oh-my-zsh/custom/themes" "$HOME/.kube"
link "$DOTFILES/mac/oh-my-zsh/custom/themes/punctual.zsh-theme" \
  "$HOME/.oh-my-zsh/custom/themes/punctual.zsh-theme"
link "$DOTFILES/mac/kube/fubectl.source" "$HOME/.kube/fubectl.source"

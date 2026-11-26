#!/usr/bin/env bash
# Link Linux dotfiles into $HOME. Safe to re-run.
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

link "$DOTFILES/linux/bashrc" "$HOME/.bashrc"
link "$DOTFILES/linux/aliases" "$HOME/.aliases"
link "$DOTFILES/linux/tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES/vimrc" "$HOME/.vimrc"
link "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/git/gitignore" "$HOME/.gitignore"

chmod +x "$DOTFILES/git/git-templates/hooks/prepare-commit-msg"
link "$DOTFILES/git/git-templates/hooks/prepare-commit-msg" \
  "$HOME/.git-templates/hooks/prepare-commit-msg"

# Ubuntu's default ~/.profile already sources ~/.bashrc. Only add a guarded
# hook when the file exists and doesn't mention .bashrc at all.
PROFILE="$HOME/.profile"
if [ -f "$PROFILE" ] && ! grep -q '\.bashrc' "$PROFILE"; then
  cat >> "$PROFILE" <<'EOF'

# dotfiles: load .bashrc for login shells
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
EOF
  printf 'updated %s to source .bashrc\n' "$PROFILE"
fi

#!/bin/sh
# Copy stdin to the system clipboard. Used by tmux's copy-mode yank bindings.
set -eu

text=$(cat)

if [ -n "${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null 2>&1; then
  printf '%s' "$text" | wl-copy
elif [ -n "${DISPLAY:-}" ] && command -v xclip >/dev/null 2>&1; then
  printf '%s' "$text" | xclip -selection clipboard
elif [ -n "${DISPLAY:-}" ] && command -v xsel >/dev/null 2>&1; then
  printf '%s' "$text" | xsel -b -i
else
  # OSC 52: works in terminals that support it, including over SSH.
  printf '\033]52;c;%s\007' "$(printf '%s' "$text" | base64 | tr -d '\n')" > /dev/tty 2>/dev/null || true
fi

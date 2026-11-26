# dotfiles

Personal dotfiles, split by platform. `LICENSE` and genuinely shared config live
at the root; everything else is platform-specific.

```
.
├── LICENSE
├── README.md
├── vimrc  git/            # shared: minimal vim + git config
├── mac/                   # macOS: zsh, oh-my-zsh, full vim, tmux + TPM, iTerm, fonts
│   ├── aliases  zshrc  tmux.conf  vimrc  setup.sh
│   ├── oh-my-zsh/  kube/  scripts/  fonts/  iterm/
└── linux/                 # Ubuntu/Beelink: bash + minimal plugin-free tmux
    ├── aliases  bashrc  tmux.conf  setup.sh
```

## Setup

Clone the repo to `~/dotfiles`, then run the script for that machine:

```sh
git clone git@github.com:dnlserrano/dotfiles.git ~/dotfiles
cd ~/dotfiles
./mac/setup.sh     # home/work Mac
./linux/setup.sh   # Beelink / Ubuntu
```

Both scripts resolve their own location, so the clone path is irrelevant. They
also create `~/.dotfiles -> <repo root>` so config files can use a stable path.
Existing files are never overwritten: symlinks that already point at the repo
are left alone, anything else is reported as skipped. Re-run them any time.

### Mac

Links `zshrc`, `aliases`, `tmux.conf`, the plugin-heavy `mac/vimrc`, the shared
git config and hook, the `punctual` oh-my-zsh theme and `kube/fubectl.source`.
Still expects oh-my-zsh, TPM (run `:PluginInstall` in tmux) and vim-plug to be
installed separately. `~/.company` is sourced only when present.

### Linux

Links `bashrc`, `aliases`, `tmux.conf`, the shared minimal `vimrc`, and the
shared git config. No oh-my-zsh, no TPM, no fzf/nvm/vim-plug — just bash and a
small tmux status bar in Ubuntu aubergine/orange: session, window list, git
branch, load average and clock, using only tmux built-ins and two tiny shell
commands. If `~/.profile` does not source `~/.bashrc`, the script appends a
guarded hook for login shells.

## Where to edit

- shared across machines → `vimrc`, `git/`
- macOS only → `mac/`
- Beelink/Ubuntu only → `linux/`

## Migrating from the old layout

Everything that used to be at the repo root now lives under `mac/` (except
`LICENSE`, which stays put): `zshrc`, `aliases`, `tmux.conf`, `vimrc`, `scripts/`,
`oh-my-zsh/`, `kube/`, `iterm/` and `fonts/`. `scripts/setup.sh` became
`mac/setup.sh`. If you had symlinks from an older setup, re-run the appropriate
setup script; it will leave unrelated files alone and report anything it skips.

`mac/vimrc` is the original plugin-heavy Vim config. The new root `vimrc` is a
small plugin-free config used on Linux; the Mac setup script keeps linking the
full one.

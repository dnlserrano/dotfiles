" Shared, plugin-free vim config (macOS + Linux).
" The full plugin-heavy config lives in mac/vimrc.

set nocompatible
set encoding=utf-8
filetype plugin indent on
syntax on

set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set backspace=indent,eol,start

set incsearch
set hlsearch
set ignorecase
set smartcase
set ruler
set wildmenu
set hidden
set noswapfile

" Remove trailing whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e

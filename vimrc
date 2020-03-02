" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-ruby/vim-ruby'
Plug 'ajh17/VimCompletesMe'
Plug 'janko/vim-test'
Plug 'jgdavey/tslime.vim'
Plug 'nono/vim-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'szw/vim-maximizer'
Plug 'elixir-lang/vim-elixir'
Plug 'qpkorr/vim-renamer'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-xmark'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-mix-format'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-unimpaired'
Plug 'ahonn/resize.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'lepture/vim-jinja'
Plug 'joshdick/onedark.vim'
Plug 'dense-analysis/ale'

call plug#end()

" Leader key
let mapleader=","

filetype off
set nocompatible
set laststatus=2
set t_Co=256
set number
set backspace=2
set clipboard=unnamed
set encoding=utf-8

" format JSON via python
nmap <Leader>j :%!python -m json.tool<CR>

" Stop auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Highlighting
set hlsearch
map <silent> <Leader>h :noh<cr>

" Hide ~ for empty lines
highlight EndOfBuffer ctermfg=black ctermbg=black

" vim-maximizer
nmap <Leader>m :MaximizerToggle<CR>

" vim-gitgutter
nmap <Leader>hn <Plug>GitGutterNextHunk
nmap <Leader>hp <Plug>GitGutterPrevHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" ale
let g:ale_elixir_elixir_ls_release = $HOME . '/.elixir-ls/release'
let g:ale_linters = {'elixir': ['elixir-ls']}
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}
let g:ale_fixers = {'elixir': ['mix_format']}
let g:ale_completion_enabled = 1

" gitgutter
let g:gitgutter_sign_added = '●'
let g:gitgutter_sign_modified = '●'
let g:gitgutter_sign_removed = '●'
let g:gitgutter_sign_modified_removed = '●'
set updatetime=250

" tmux-like splitting
nmap <Leader>% :vs<CR>
nmap <Leader>@ :sp<CR>

" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" Debuggers
function! AddDebug()
  let extension = expand('%:e')

  if (extension == 'ex' || extension == 'exs')
    call append('.', 'require IEx; IEx.pry')
  elseif (extension == 'rb' || extension == 'erb')
    call append('.', 'require "pry"; binding.pry')
  elseif (extension == 'py')
    call append('.', 'import pdb; pdb.set_trace()')
  endif
endfunction

nmap <silent> <Leader>p :call AddDebug()<CR>

" Buffer navigation
nmap <Leader>bp :bprevious<CR>
nmap <Leader>bn :bnext<CR>

" vim-test mappings
nmap <silent> <Leader>t :TestFile<CR>
let test#strategy = "tslime"

" tslime.vim
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

" Spaces instead of tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Auto-indentation
set autoindent
set smartindent

" Remove whitespaces on write
autocmd BufWritePre * :%s/\s\+$//e

" Breaking the habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Breakline in normal mode
nnoremap K i<CR><ESC>

" lightline.vim
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" vim-projectionist
let g:projectionist_heuristics = {
      \   "mix.exs": {
      \     "lib/*.ex": {
      \       "type": "lib",
      \       "alternate": "test/{}_test.exs",
      \       "template": ["defmodule {camelcase|capitalize|dot} do", "end"],
      \     },
      \     "test/*_test.exs": {
      \       "type": "test",
      \       "alternate": "lib/{}.ex",
      \       "template": ["defmodule {camelcase|capitalize|dot}Test do", "  use ExUnit.Case, async: true", "", "end"],
      \     },
      \     "mix.exs": {"type": "mix"},
      \     "config/*.exs": {"type": "config"},
      \   }
      \ }
nmap <silent> <leader>a :AV<CR>

" NERDTree
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE

function! IsNerdTreeEnabled()
  return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

function! MyNerdToggle()
  if IsNerdTreeEnabled() || bufname('%') == ''
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction

nnoremap <silent> <C-n> :call MyNerdToggle()<CR>

" fzf
nnoremap <silent> <Space> :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <Leader>gl :Commits<CR>

nmap <silent> <C-p> :Files <CR>
command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --hidden --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \     : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

" CTRL-Q to select all (to then press Enter to send it to quickfix)
let $FZF_DEFAULT_OPTS = '--bind ctrl-q:select-all'

" read large files
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no plugins
 set runtimepath=~/.vim
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

syntax enable
colorscheme onedark
hi Normal ctermbg=none

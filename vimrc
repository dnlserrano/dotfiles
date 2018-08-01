" Leader key
let mapleader=","

syntax enable
filetype off
colorscheme solarized
set nocompatible
set laststatus=2
set t_Co=256
set background=dark
set number
set backspace=2
set clipboard=unnamed

" Stop auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Buffer listing
nmap <Space> :Buffers<CR>

" Highlighting
set hlsearch
map <silent> <Leader>h :noh<cr>

" vim-maximizer
nmap <Leader>m :MaximizerToggle<CR>

" tmux-like splitting
nmap <Leader>% :vs<CR>
nmap <Leader>" :sp<CR>

" Debuggers
function! AddDebug()
  let extension = expand('%:e')

  if (extension == 'ex' || extension == 'exs')
    call append('.', 'require IEx; IEx.pry')
  elseif (extension == 'rb')
    call append('.', 'require "pry"; binding.pry')
  elseif (extension == 'py')
    call append('.', 'import pdb; pdb.set_trace()')
  endif
endfunction

nmap <silent> <Leader>p :call AddDebug()<CR>

" Buffer navigation
nmap <Leader>bp :bprevious<CR>
nmap <Leader>bn :bnext<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>r :call RunNearestSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_runner = "os_x_iterm2"
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'

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

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#format = 1

" vim-airline-themes
let g:airline_theme='solarized'

" NERDTree
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

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<F5>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

" fzf
nmap <silent> <C-p> :Files <CR>
command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \     : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

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

" vim-plug
call plug#begin('~/.vim/plugged')

" vim-fugitive
nnoremap <Leader>gl :silent Glog<CR>

" vim-gutentags
let g:gutentags_cache_dir='~/.vim/plugged/vim-gutentags/tags/'

" vim-gitgutter
nmap <Leader>hn <Plug>GitGutterNextHunk
nmap <Leader>hp <Plug>GitGutterPrevHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'vim-ruby/vim-ruby'
Plug 'ajh17/VimCompletesMe'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/tslime.vim'
Plug 'nono/vim-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'szw/vim-maximizer'
Plug 'terryma/vim-multiple-cursors'
Plug 'elixir-lang/vim-elixir'
Plug 'qpkorr/vim-renamer'
Plug 'godlygeek/tabular'
Plug 'kchmck/vim-coffee-script'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-xmark'
Plug 'ludovicchabant/vim-gutentags'
Plug 'airblade/vim-gitgutter'
" Plug 'hallettj/jslint.vim'
" Plug 'tpope/vim-surround'

call plug#end()

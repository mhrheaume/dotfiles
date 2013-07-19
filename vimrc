"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700
set autoread
set nocompatible
set hidden
let mapleader = ','

set autochdir
set autoread
set autowrite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set number
set magic
set showmatch
set mat=2

set t_Co=256
" colors desert256
" hi Normal ctermbg=NONE
"
let g:jellybeans_overrides = {
\	'Search': {'ctermfg': 'f5deb3', 'ctermbg': 'cd853f',
\		'guifg': 'f5deb3', 'guibg': 'cd853f',
\		'attr': ''},
\}
colors jellybeans

hi Normal ctermbg=NONE
hi NonText ctermbg=NONE
hi SpecialKey ctermbg=NONE
hi LineNr ctermbg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set autoindent
set smartindent

set listchars=tab:>-
set list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set incsearch
set ignorecase
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Easier navigation for wrapped lines
nmap j gj
nmap k gk

nmap <leader>n :bnext<CR>
nmap <leader>p :bprev<CR>

nmap <leader>h <C-w>h
nmap <leader>l <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'

filetype plugin on

let g:ycm_confirm_extra_conf = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Overrides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufRead,BufNewFile $CS452/* set tabstop=2 shiftwidth=2
" autocmd BufRead,BufNewFile $CS444/* set noexpandtab

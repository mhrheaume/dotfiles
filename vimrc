"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700
set autoread
set nocompatible
set hidden
let mapleader = ' '

"set autochdir
set autoread
set autowrite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set number
set magic
set showmatch
set ruler
set mat=2
set completeopt-=preview
set laststatus=2

set t_Co=256
let g:jellybeans_overrides = {
\	'Search': {
\		'ctermfg': 'f5deb3',
\		'ctermbg': 'cd853f',
\		'guifg': 'f5deb3',
\		'guibg': 'cd853f',
\		'attr': ''
\	},
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

au BufRead,BufNewFile *.thrift set filetype=thrift
au Syntax thrift source ~/.vim/syntax/thrift.vim

au BufRead,BufNewFile *.scala set filetype=scala
au Syntax scala source ~/.vim/syntax/scala.vim

au BufRead,BufNewFile *.aurora set filetype=python
au BufRead,BufNewFile BUILD* set filetype=python

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set tabstop=4
set smarttab
set autoindent
set smartindent
set textwidth=79

set listchars=tab:>-
set list

set backspace=indent,eol,start

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Insert Macros
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap {        {}<Left>
inoremap {<CR>    {<CR>}<Esc>O
inoremap {{       {
inoremap {}       {}

inoremap (        ()<Left>
inoremap ((       (
inoremap ()       ()

inoremap [        []<Left>
inoremap [[       [
inoremap []       []

inoremap <        <><Left>
inoremap <<Space> <<Space>
inoremap <=       <=

inoremap "        ""<Left>
inoremap ""       "

inoremap '        ''<Left>
inoremap ''       '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on

Bundle 'gmarik/vundle'

" YouCompletMe completion
Bundle 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf = 0

" Ctrl-P fuzzy file finder
Bundle 'kien/ctrlp.vim'
nmap <leader>t :CtrlP .<CR>
let g:ctrlp_custom_ignore = {
\	'dir': '\v(\.git|target)$'
\}

" Gocode completion, formatting for golang
Bundle 'Blackrush/vim-gocode'
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0

" Eclim (installed outside of Vundle)
let g:EclimCompletionMethod = 'omnifunc'
nmap <leader>pt  :ProjectTreeToggle<CR>
nmap <leader>pr  :ProjectRefresh<CR>
nmap <leader>ji  :JavaImport<CR>
nmap <leader>jr  :JavaRename<CR>
nmap <leader>jc  :JavaCorrect<CR>
nmap <leader>jg  :JavaGet<CR>
nmap <leader>js  :JavaSet<CR>
nmap <leader>jgs :JavaGetSet<CR>
nmap <leader>jsc :JavaSearchContext<CR>

" Lightline status bar
Bundle 'itchyny/lightline.vim'
let g:lightline = {
\	'colorscheme': 'jellybeans'
\}

" Buffer explorer, surround
Bundle 'fholgado/minibufexpl.vim'
Bundle 'tpope/vim-surround'

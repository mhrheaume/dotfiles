"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700
set autoread
set nocompatible
set hidden
let mapleader = ' '

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
syntax on

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

" hi Normal ctermbg=NONE
" hi NonText ctermbg=NONE
" hi SpecialKey ctermbg=NONE
" hi LineNr ctermbg=NONE

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

au BufRead,BufNewFile *.pig set filetype=pig
au BufRead,BufNewFile *.piglet set filetype=pig
au Syntax pig source ~/.vim/syntax/pig.vim

au BufRead,BufNewFile *.aurora set filetype=python
au BufRead,BufNewFile BUILD* set filetype=python

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=2
set tabstop=2
set smarttab
set expandtab
set autoindent
set smartindent

set listchars=tab:>-
set list

set backspace=indent,eol,start

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Strip trailing whitespace when files are saved
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set incsearch
set ignorecase
set smartcase

set tagstack
set tags=./tags;/,~/.scalatags,~/.javatags

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
inoremap <-       <-

inoremap "        ""<Left>
inoremap ""       "

inoremap '        ''<Left>
inoremap ''       '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set nomodeline
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle'

" YouCompleteMe completion
" Plugin 'Valloric/YouCompleteMe'
" let g:ycm_confirm_extra_conf = 0

" Ctrl-P fuzzy file finder
Plugin 'kien/ctrlp.vim'
nmap <leader>t :CtrlP .<CR>
let g:ctrlp_custom_ignore = {
\	'dir': '\v(\.git|target)$'
\}

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
nmap <leader>si  :ScalaImport<CR>
nmap <leader>ss  :ScalaSearch<CR>

" Lightline status bar
Plugin 'itchyny/lightline.vim'
let g:lightline = {
\	'colorscheme': 'jellybeans'
\}

" Buffer explorer, surround
Plugin 'fholgado/minibufexpl.vim'
Plugin 'tpope/vim-surround'

" Working with mustache and handlebars templates
Plugin 'mustache/vim-mustache-handlebars'

call vundle#end()
filetype plugin indent on

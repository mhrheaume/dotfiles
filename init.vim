"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" UI Plugins
Plug 'nanotech/jellybeans.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

" Editing
Plug 'tpope/vim-surround'

" Languages
Plug 'rust-lang/rust.vim'
Plug 'solarnz/thrift.vim'
Plug 'udalov/kotlin-vim'

" FZF
Plug '/opt/homebrew/opt/fzf'
nnoremap <leader>t :call fzf#run({'sink': 'e'})<CR>
nnoremap <leader>gt :call fzf#run({'source': 'git ls-files', 'sink': 'e'})<CR>

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:python3_host_prog = '/opt/homebrew/bin/python3'
let g:deoplete#enable_at_startup = 1

" Deoplate Plugins
Plug 'deoplete-plugins/deoplete-jedi'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700
set autoread
set nocompatible
set hidden

set autoread
set autowrite

set visualbell
set noerrorbells

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UI
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
set termguicolors
colorscheme gruvbox

let g:lightline = {
\	'colorscheme': 'gruvbox'
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :help ft-python-plugin
let g:python_recommended_style = 0

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
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

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
" Disable mouse
set mouse=

map <Space> <leader>

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

" Map Ctrl+[ to esc
nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

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

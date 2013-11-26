let g:pathogen_disabled = [ 'pathogen' ]
call pathogen#infect()
call pathogen#helptags()

set nocompatible
syntax on
filetype on
filetype plugin on
filetype plugin on
filetype plugin indent on

set showfulltag
set showcmd
set showmatch
set showmode
set ruler
set wildmenu

set background=dark
colorscheme ir_black

set tabstop=4
set autoindent
set smarttab
set shiftwidth=4
set undolevels=1000
set expandtab
set backspace=start,indent,eol
set nofoldenable foldmethod=indent

set t_Co=256

map <F8> :set invpaste<CR>
set pastetoggle=<F8>

let mapleader=","
let g:pep8_map='<leader>8'
let g:pyflakes_use_quickfix = 0

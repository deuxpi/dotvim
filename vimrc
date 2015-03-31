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
set t_Co=16
colorscheme solarized

set tabstop=4
set autoindent
set smarttab
set shiftwidth=4
set undolevels=1000
set expandtab
set backspace=start,indent,eol
set nofoldenable foldmethod=indent
"set colorcolumn=80
set nowrap

autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd FileType css,javascript,xhtml,html,xml :set ts=2 sw=2 sts=2 et
autocmd FileType make :set ts=4 noet nolist

map <F8> :set invpaste<CR>
set pastetoggle=<F8>

let mapleader=","
let g:pep8_map='<leader>8'
let g:pyflakes_use_quickfix = 0
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
"autocmd BufWritePost *.py call Flake8()

vmap Q gq
nmap Q gqap

noremap q: <C-l>
noremap q? <C-l>

" Transparent editing of GnuPG-encrypted files
" Based on a solution by Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg,*.asc set viminfo=
  " We don't want a swap file, as it writes unencrypted data to disk.
  autocmd BufReadPre,FileReadPre *.gpg,*.asc set noswapfile
  " Switch to binary mode to read the encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg,*.asc let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost *.gpg,*.asc
    \ '[,']!sh -c 'gpg --decrypt 2> /dev/null'
  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg,*.asc let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg,*.asc
    \ execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  autocmd BufWritePre,FileWritePre *.gpg set bin
  autocmd BufWritePre,FileWritePre *.gpg
    \ '[,']!sh -c 'gpg --default-recipient-self -e 2>/dev/null'
  autocmd BufWritePre,FileWritePre *.asc
    \ '[,']!sh -c 'gpg --default-recipient-self -e -a 2>/dev/null'
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg,*.asc u
augroup END

let g:languagetool_jar='~/.vim/bundle/LanguageTool/LanguageTool-2.8/languagetool-commandline.jar'

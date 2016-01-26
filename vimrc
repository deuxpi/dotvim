let g:pathogen_disabled = [ 'pathogen' ]
call pathogen#infect()
call pathogen#helptags()

set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

set showfulltag
set showcmd
set showmode
set ruler
set wildmenu
set magic

" Blink matching brackets for some tenth of a second
set showmatch
set mat=2

" Syntax highlighting
syntax on
set background=dark
set t_Co=256

if hostname() == "mail"
  colorscheme ir_black
else
  colorscheme solarized
  let g:solarized_visibility="low"
endif

set undolevels=1000
set backspace=start,indent,eol

" Code formatting, tabs to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set nowrap

" Typically useful for Python code
set nofoldenable foldmethod=indent

" Turn all kinds of temporary files off
set nobackup
set nowb
set noswapfile

" Override some formatting defaults based on the filetype
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd FileType css,javascript,xhtml,html,xml :set ts=2 sw=2 sts=2 et
autocmd FileType make :set ts=4 noet nolist

" Toggle code formatting when pasting chunks of text. Ridiculously useful.
map <F8> :set invpaste<CR>
set pastetoggle=<F8>

" Enable extra key combinations like <leader>q to reformat a paragraph.
let mapleader=","

" When using the older PEP8 plugin, execute by typing <leader>8.
" let g:pep8_map='<leader>8'

" Configure Flake8
let g:pyflakes_use_quickfix = 0
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
"autocmd BufWritePost *.py call Flake8()

vmap <leader>q gq
nmap <leader>q gqap

noremap q: <C-l>
noremap q? <C-l>

" Highlight suspicious characters based on
" https://wincent.com/blog/making-vim-highlight-suspicious-characters
set listchars=space:␣,nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
highlight NonText term=none cterm=none ctermfg=0 ctermbg=8 gui=none
highlight SpecialKey term=none cterm=none ctermfg=0 ctermbg=8 gui=none
map <F9> :set invlist<CR>

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

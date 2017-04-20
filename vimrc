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
  let g:solarized_visibility = "low"
  let g:solarized_term = 1
endif

set undolevels=1000
set backspace=start,indent,eol
set scrolloff=1
set sidescrolloff=5

" Code formatting, tabs to 4 spaces
set autoindent
set expandtab
set nrformats-=octal
set tabstop=4
set shiftwidth=4
set smarttab
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
autocmd FileType ruby :set ts=2 sw=2 sts=2 et
autocmd FileType make :set ts=4 noet nolist
autocmd BufNewFile,BufRead *.mrb set filetype=ruby
autocmd FileType ruby,eruby :set ts=2 sw=2
autocmd FileType liquid :set noeol

" Toggle code formatting when pasting chunks of text. Ridiculously useful.
map <F8> :set invpaste<CR>
set pastetoggle=<F8>

" Automatically jump to end of text just pasted
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Enable extra key combinations like <leader>q to reformat a paragraph.
let mapleader=","

" Configure Flake8
let g:pyflakes_use_quickfix = 0
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

vmap <leader>q gq
nmap <leader>q gqap

noremap q: <C-l>
noremap q? <C-l>
command -bang Q q<bang>

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

" LanguageTool
let g:languagetool_jar='~/.vim/bundle/LanguageTool/LanguageTool-2.8/languagetool-commandline.jar'

" vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1

" vim-json
let g:vim_json_syntax_conceal = 0

" supertab
let g:SuperTabDefaultCompletionType = '<C-n>'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_asm_checkers = []
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_show_diagnostics_ui = 0

" fzf
set rtp+=/usr/local/opt/fzf

" vim-rubocop
let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop'

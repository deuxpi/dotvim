set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'Shopify/shadowenv.vim'

Plug 'deuxpi/vim-fairyfloss'

call plug#end()


if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set autoindent
set backspace=indent,eol,start
set smarttab

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options

set showfulltag
set showcmd
set showmode
set magic

" Blink matching brackets for some tenth of a second
set showmatch
set mat=2

colorscheme fairyfloss_dark
set termguicolors

highlight clear SignColumn

set nofoldenable
set cmdheight=2
set formatoptions-=cro
set updatetime=300
set shortmess+=c
set signcolumn=number
set hidden

" Code formatting, tabs to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set nowrap

set undolevels=1000

" Typically useful for Python code
set nofoldenable foldmethod=indent

" Turn all kinds of temporary files off
set nobackup
set nowritebackup
set noswapfile

set viminfo='100,<1000,s100,h

" Override some formatting defaults based on the filetype
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.mrb set ft=ruby
autocmd BufNewFile,BufRead *.rbi set ft=ruby
autocmd BufNewFile,BufRead *.ts set ft=javascript
autocmd BufNewFile,BufRead *.tsx set ft=javascript
autocmd FileType coffee,css,javascript,json,html,scss,xhtml,xml :set ts=2 sw=2 sts=2 et ch=2
autocmd FileType lua :set ts=2 sw=2 sts=2
autocmd FileType make :set ts=4 noet nolist
autocmd FileType ruby,eruby :set ts=2 sw=2 sts=2 et cc=120
autocmd FileType liquid :set noeol

" x = if condition
"   something
" end
let g:ruby_indent_assignment_style = 'variable'

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

" Coc
let g:coc_disable_startup_warning = 1

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-@> coc#refresh()

autocmd CursorHold * silent call CocActionAsync('highlight')


vmap <leader>q gq
nmap <leader>q gqap

noremap q: <C-l>
noremap q? <C-l>
command -bang Q q<bang>
command -bang W w<bang>

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


" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='bubblegum'

" ale
let g:ale_disable_lsp = 1
let g:ale_linters = {'ruby': ['rubocop'], 'eruby': ['erblint'], 'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint'], 'ruby': ['rubocop']}
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_eruby_erblint_executable = 'bundle'
nmap <leader>f <Plug>(ale_fix)

" vim-gitgutter
let g:gitgutter_sign_added = '●'
let g:gitgutter_sign_modified = '●'
let g:gitgutter_sign_removed = '●'
let g:gitgutter_sign_removed_first_line = '●↑'
let g:gitgutter_sign_modified_removed = '●'

" vim-json
let g:vim_json_syntax_conceal = 0

" fzf
set rtp+=/usr/local/opt/fzf

" vim-rubocop
let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop'

" vim-test
let test#strategy = "dispatch"
nmap <silent> tt :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
let test#ruby#minitest#options = '-p'
let test#ruby#rails#options = '-p'

autocmd FileType ruby syn match sorbetSignature "\<sig\>" nextgroup=sorbetSignatureDeclaration skipwhite skipnl
autocmd FileType ruby syn region sorbetSignatureBlock start="sig {" end="}"
autocmd FileType ruby syn region sorbetSignatureBlock start="\<sig\> \<do\>" matchgroup=sorbetSignature end="\<end\>"
autocmd FileType ruby hi def link sorbetSignature Comment
autocmd FileType ruby hi def link sorbetSignatureBlock Comment

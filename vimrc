" Init pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
syntax enable
filetype plugin indent on

" Key mappings
" disable arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
imap jj <esc>
map <C-n> :NERDTree <Enter>
map <C-a> GVgg

set encoding=utf-8
set relativenumber
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set expandtab
set list listchars=tab:→\ ,trail:·
filetype plugin on
set omnifunc=syntaxcomplete#Complete
:syntax on
set gfn=Courier\ New
set backspace=2
set backspace=indent,eol,start

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif

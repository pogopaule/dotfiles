" Init pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
syntax enable
filetype plugin indent on


set number
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
filetype plugin on
set omnifunc=syntaxcomplete#Complete
:syntax on
imap jk <esc>
set gfn=Courier\ New
set backspace=2
set backspace=indent,eol,start

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif

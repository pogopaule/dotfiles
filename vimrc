" Init pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
syntax enable
filetype plugin indent on

set background=light
colorscheme solarized

" Key mappings
let mapleader=","
" disable arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" Shortcuts
imap jj <esc>
map <C-n> :NERDTree <Enter>
map <C-a> GVgg
nnoremap <leader>ff :%!js-beautify -k -s 2 -f -<CR>
nmap <CR> o<Esc>
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left> 

set encoding=utf-8
set number
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

set foldlevelstart=10
set foldmethod=indent

let g:mustache_abbreviations = 1

set noswapfile

" Search
set hlsearch

" Settings for ctrlp plugin
set wildignore+=*/vendor/*,*/node_modules/*,*/tmp/*,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\vendor\\*,*\\node_modules\\*,*\\tmp\\*,.swp,*.zip,*.exe  " Windows

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif

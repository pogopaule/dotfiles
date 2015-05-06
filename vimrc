" Init pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
syntax enable
filetype plugin indent on

let g:syntastic_javascript_checkers = ['jscs']
let g:syntastic_javascript_jscs_args = "--esnext"

set background=light
colorscheme solarized
set t_Co=256

set autoread
set noundofile
set nowritebackup
set nobackup

" airline plugin config
set laststatus=2

" Under Cygwin: Block cursor in command mode. see http://superuser.com/questions/634326/how-can-i-get-a-block-cursor-in-vim-in-the-cygwin-terminal/
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

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
imap jk <esc>
map <C-n> :NERDTreeToggle<Enter>
nnoremap <leader>ff :%!jscs -x --esnext<CR>
nmap <CR> o<Esc>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>q :wq<CR>
nmap <C-a> :Ag 

" move between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" move nicer in wrapped lines
nmap j gj
nmap k gk

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
syntax on
set gfn=Courier\ New
set backspace=2
set backspace=indent,eol,start

set foldlevelstart=10
set foldmethod=indent

let g:mustache_abbreviations = 1

set noswapfile

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap <leader>n :nohlsearch<CR>

" Settings for ctrlp plugin
set wildignore+=*/vendor/*,*/node_modules/*,*/tmp/*,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\vendor\\*,*\\node_modules\\*,*\\tmp\\*,.swp,*.zip,*.exe  " Windows

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif

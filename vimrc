" Init pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
syntax enable
filetype plugin indent on

" General Settings
" ----------------

" configure color scheme
set background=light
colorscheme solarized
set t_Co=256

" omni completion http://vim.wikia.com/wiki/Omni_completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" filehandling
set autoread
set noundofile
set nowritebackup
set nobackup
set noswapfile
set hidden
set encoding=utf-8

" indentation
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set expandtab
set list listchars=tab:→\ ,trail:·
set backspace=2
set backspace=indent,eol,start

" show linenumbers
set number

" syntax highlighting
syntax on

set gfn=Courier\ New

" Under Cygwin: Block cursor in command mode. see http://superuser.com/questions/634326/how-can-i-get-a-block-cursor-in-vim-in-the-cygwin-terminal/
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" folding
set foldlevelstart=10
set foldmethod=indent
" fold with space
nnoremap <Space> za

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

" MacVim
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif



" Keymappings
" -----------

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

" exit insert mode by pressing jk
imap jk <esc>

" new tab shortcut
nnoremap <leader>t :tabnew<CR>

" copy paste from system clipboard
vnoremap <leader>p "+p
vnoremap <leader>y "+y

" search and replace
nnoremap <leader>a :Ag
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" write and quit shortcuts
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>e :qa<CR>

" remove search highlight
nnoremap <leader>d :nohlsearch<CR>

" enter adds new line in normal mode
nmap <CR> o<Esc>

noremap cp yap<S-}>p

" move between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" move nicer in wrapped lines
nmap j gj
nmap k gk



" Plugins
" -------

" CTRL-P
set wildignore+=*/vendor/*,*/node_modules/*,*/tmp/*,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\vendor\\*,*\\node_modules\\*,*\\tmp\\*,.swp,*.zip,*.exe  " Windows

" airline
set laststatus=2

" mustache
let g:mustache_abbreviations = 1

" NERDTree settings
nnoremap <C-n> :NERDTreeToggle<Enter>
nnoremap <leader>n :NERDTreeFind<Enter>

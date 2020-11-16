" Plugins
" ----------------
"
" This vimrc assumes plug being installed as a package manager. See https://github.com/junegunn/vim-plug#unix
"
call plug#begin('~/.vim/plugged')

" More text objects
Plug 'wellle/targets.vim'

" Smooth scrolling
Plug 'psliwka/vim-smoothie'

" File Explorer
Plug 'scrooloose/nerdtree'

" Fuzzy Finder
Plug 'ctrlpvim/ctrlp.vim'

" Ag Plugin
Plug 'mileszs/ack.vim'

" Surround quotes, brackets, etc.
Plug 'tpope/vim-surround'

" Comments
Plug 'scrooloose/nerdcommenter'

" Insert matching quote, brackets, etc.
Plug 'jiangmiao/auto-pairs'

" Quick navigation
Plug 'easymotion/vim-easymotion'

" Solarized colors
Plug 'altercation/vim-colors-solarized'

" Status bar
Plug 'vim-airline/vim-airline'

" Seamless jumping between vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" Substitution...
Plug 'tpope/vim-abolish'

" Emmet
Plug 'mattn/emmet-vim'

" Syntax highlighting for vim components
Plug 'leafOfTree/vim-vue-plugin'

" Handlebars support
Plug 'mustache/vim-mustache-handlebars'

" Start screen
Plug 'mhinz/vim-startify'

" Tabularize
Plug 'godlygeek/tabular'

" Syntax checker
Plug 'scrooloose/syntastic'

" Markdown
Plug 'plasticboy/vim-markdown'

" Not sure if i need those...
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'

" Initialize plugin system
call plug#end()

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

" show relative linenumbers
set number relativenumber

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
noremap <leader>p "+p
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

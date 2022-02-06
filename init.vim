set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Plugins {{{
" https://github.com/junegunn/vim-plug#unix

call plug#begin('~/.vim/plugged')

" LSP support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" Plug 'glepnir/lspsaga.nvim'

" Lua functions
Plug 'nvim-lua/plenary.nvim'

" git decoration for buffers
Plug 'lewis6991/gitsigns.nvim'

" Git
Plug 'tpope/vim-fugitive'

" completion engine
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Find, Filter, Preview, Pick
Plug 'nvim-telescope/telescope.nvim'

" Highlight, list and search todo comments
Plug 'folke/todo-comments.nvim'

" Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Smooth scrolling
Plug 'psliwka/vim-smoothie'

" open file in github
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'

" Surround quotes, brackets, etc.
Plug 'tpope/vim-surround'

" Comments
Plug 'numToStr/Comment.nvim'

" Colorize hex colors
Plug 'norcalli/nvim-colorizer.lua'

" Insert matching quote, brackets, etc.
Plug 'jiangmiao/auto-pairs'

" Quick navigation
Plug 'easymotion/vim-easymotion'

" Solarized colors
Plug 'altercation/vim-colors-solarized'

" One theme
Plug 'rakr/vim-one'

" Status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Seamless jumping between vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" Substitution...
Plug 'tpope/vim-abolish'

" Emmet
Plug 'mattn/emmet-vim'

" Tabularize
Plug 'godlygeek/tabular'

" Linting
"Plug 'dense-analysis/ale'

" Markdown
Plug 'preservim/vim-markdown'

" File Explorer
Plug 'kyazdani42/nvim-tree.lua'

" Start screen
Plug 'mhinz/vim-startify'


" Initialize plugin system
call plug#end()
"}}}

" General Settings {{{

" configure color scheme {{
colorscheme one
"set background=dark " for the dark version
set background=light " for the light version
set termguicolors
"}}

" filehandling {{
set noundofile
set nowritebackup
set nobackup
set noswapfile
"}}

" indentation {{
set shiftwidth=2
set tabstop=2
set smartindent
set expandtab
set backspace=2
"}}

" show relative linenumbers
set number relativenumber

" folding {{{
set foldlevelstart=10
" fold with space
" }}}

" search {{
set ignorecase
set smartcase
"}}

"}}}

" Keymappings {{{

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
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" write and quit shortcuts
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

" remove search highlight
nnoremap <leader>d :nohlsearch<CR>

" enter adds new line in normal mode
nmap <CR> o<Esc>

" move between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" move nicer in wrapped lines
nmap j gj
nmap k gk

" nvim-telescope/telescope.nvim {{
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ft <cmd>TodoTelescope<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
" }}

" tyru/open-browser-github.vim {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nmap gxx <cmd>OpenGithubFile<cr>
" }}}

" scrooloose/nerdtree {{{
nnoremap <C-n> :NvimTreeToggle<Enter>
nnoremap <leader>n :NvimTreeFindFile<Enter>
"}}}


"}}}


" Plugin Configurations {{{

" " glepnir/lspsaga.nvim {{{
" lua require('lspsaga').init_lsp_saga()
" " }}}

" lewis6991/gitsigns.nvim {{{
lua require('gitsigns').setup()
" }}}

" nvim-tree {{{
lua require'nvim-tree'.setup()
" }}}

" numToStr/Comment.nvim {{{
lua require('Comment').setup()
"}}}

" folke/todo-comments.nvim {{{
lua require("todo-comments").setup()
" }}}

" kyazdani42/nvim-web-devicons {{{
lua <<EOF
require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF
"}}}

" nvim-lualine/lualine.nvim {{{
lua require('lualine').setup()
" }}}

" nvim-colorizer.lua {{{
lua require('colorizer').setup()
" }}}

" nvim-treesitter/nvim-treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
"}}}

" williamboman/nvim-lsp-installer {{{
lua <<EOF
local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)

EOF
" }}}

" neovim/lspconfig {{{
lua <<EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
EOF

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gca   <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <silent><leader>fo <cmd>lua vim.lsp.buf.formatting()<CR>
" }}}

" hrsh7th/nvim-cmp {{{
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
EOF
"}}}

" Spell, Grammar and Thesaurus
" https://www.vimfromscratch.com/articles/spell-and-grammar-vim/
set thesaurus+=~/.vim/thesaurii.txt
autocmd FileType markdown setlocal spell

"}}}

" mhinz/vim-startify {{{
let g:startify_change_to_vcs_root = 1
let g:startify_custom_header =[]      " Disable startify header
" }}}



local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end


-- TODO: migrate to lua autocmd
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end


-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}


-- TODO: checkout plugins
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/jose-elias-alvarez/typescript.nvim additional lsp features for typescript, mainly imports related
-- https://github.com/ms-jpq/coq_nvim alternative to vim-cmp?
-- https://github.com/ms-jpq/chadtree alternative to nvim-tree?
-- https://github.com/danymat/neogen generate annotations and documentation
-- https://github.com/anuvyklack/hydra.nvim some keybinding stuff
-- https://github.com/ThePrimeagen/harpoon naviage favorite locations


return packer.startup(function(use)
  -- INCUBATOR: not sure if these plugins should be kept
  use 'https://github.com/nvim-treesitter/playground'                            -- treesitter playground, show syntax tree
  use { 'https://github.com/ldelossa/gh.nvim',                                   -- Code reviews in vim
    requires = { { 'https://github.com/ldelossa/litee.nvim' } }
  }
  use 'https://github.com/haringsrob/nvim_context_vt'                            -- Shows virtual text after functions, methods, statements, etc.

  use 'https://github.com/dbeniamine/cheat.sh-vim'                               -- cheat.sh integration
  use 'pwntester/octo.nvim'                                                     -- github integration
  use 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'           -- Text objects like functions and variables
  -- use 'https://github.com/editorconfig/editorconfig-vim'                         -- editorconfig integration
  -- use 'https://github.com/jamestthompson3/nvim-remote-containers'                -- use vscode's container definitions in nvim
  -- use 'https://github.com/dstein64/vim-startuptime'                              -- measure startup time


  -- basics
  use 'https://github.com/wbthomason/packer.nvim'                                -- Have packer manage itself
  use 'https://github.com/nvim-lua/popup.nvim'                                   -- Popup API from vim in neovim
  use 'https://github.com/nvim-lua/plenary.nvim'                                 -- Lua functions
  use 'https://github.com/antoinemadec/FixCursorHold.nvim'                       -- fix CursorHold performance


  -- layout / windows
  use 'https://github.com/kyazdani42/nvim-tree.lua'                              -- File Explorer
  use 'https://github.com/goolord/alpha-nvim'                                    -- Start screen
  use 'https://github.com/nvim-lualine/lualine.nvim'                             -- Status bar
  use 'https://github.com/kyazdani42/nvim-web-devicons'                          -- Icon font
  use { 'https://github.com/EdenEast/nightfox.nvim',                             -- nightfox theme
    run = ':NightfoxCompile', }
  use 'https://github.com/akinsho/bufferline.nvim'                               -- buffers as tabs
  use 'https://github.com/kazhala/close-buffers.nvim'                            -- helpers to close buffers, used by bufferline


  -- moving around
  use 'https://github.com/ggandor/leap.nvim'                                     -- Jump in text
  use 'https://github.com/nvim-telescope/telescope.nvim'                         -- Find, Filter, Preview, Pick
  use 'https://github.com/nvim-telescope/telescope-ui-select.nvim'               -- use telescope to select options


  -- misc
  use 'https://github.com/godlygeek/tabular'                                     -- Tabularize
  use 'https://github.com/zakharykaplan/nvim-retrail'                            -- Show and remove unwanted whitespaces
  use 'https://github.com/christoomey/vim-tmux-navigator'                        -- Seamless jumping between vim and tmux
  use 'https://github.com/airblade/vim-rooter'                                   -- Changes Vim working directory to project root
  use 'https://github.com/karb94/neoscroll.nvim'                                 -- smooth scrolling
  use 'https://github.com/folke/which-key.nvim'                                  -- shows what to type after a prefix
  use { 'https://github.com/renerocksai/telekasten.nvim',                        -- zettelkasten
    requires = { { 'https://github.com/renerocksai/calendar-vim' } }
  }
  -- FIXME: make xdg-open work
  use 'https://github.com/tyru/open-browser.vim'                                 -- open url or word as search in browser
  use 'lewis6991/impatient.nvim'                                                 -- speed up startup


  -- coding
  use { 'https://github.com/nvim-treesitter/nvim-treesitter',                    -- Nvim Treesitter configurations and abstraction layer
    run = ':TSUpdate' }
  use 'https://github.com/andymass/vim-matchup'                                  -- extends %
  use 'https://github.com/kylechui/nvim-surround'                                -- easily surround with brackets
  use 'https://github.com/numToStr/Comment.nvim'                                 -- Comments
  use 'https://github.com/norcalli/nvim-colorizer.lua'                           -- Colorize hex colors
  use 'https://github.com/windwp/nvim-autopairs'                                 -- Insert matching quote, brackets, etc.
  use 'https://github.com/folke/todo-comments.nvim'                              -- Highlight, list and search todo comments
  use 'https://github.com/preservim/vim-markdown'                                -- Markdown
  use 'https://github.com/ThePrimeagen/refactoring.nvim'                         -- Refactoring
  use 'https://github.com/davidgranstrom/nvim-markdown-preview'                  -- Preview markdown, requires live-preview and pandoc to be installed
  use 'https://github.com/jpalardy/vim-slime'                                    -- Send line to tmux
  use 'https://github.com/b0o/schemastore.nvim'                                  -- JSON schema awareness, gives LSP completions for e.g. package.json


  -- testing
  use 'https://github.com/nvim-neotest/neotest'
  use 'https://github.com/nvim-neotest/neotest-python'


  -- debugging
  use 'https://github.com/mfussenegger/nvim-dap'
  use 'https://github.com/rcarriga/nvim-dap-ui'
  use 'https://github.com/nvim-telescope/telescope-dap.nvim'
  use 'https://github.com/theHamsta/nvim-dap-virtual-text'


  -- LSP
  use 'https://github.com/neovim/nvim-lspconfig'                                 -- LSP support
  use 'https://github.com/glepnir/lspsaga.nvim'                                  -- The neovim language-server-client UI
  use 'https://github.com/onsails/lspkind-nvim'                                  -- vscode-like pictograms for neovim lsp completion items
  use 'https://github.com/jose-elias-alvarez/null-ls.nvim'                       -- LSP bridge for linters and others
  use 'williamboman/mason.nvim'                                                  -- Easy installation of LSP servers
  use 'williamboman/mason-lspconfig.nvim'
  use 'https://github.com/ray-x/lsp_signature.nvim'                              -- LSP signature hint as you type
  use 'https://github.com/j-hui/fidget.nvim'                                     -- Show LSP progress
  use 'https://github.com/folke/trouble.nvim'                                    -- Nicer diagnostics


  -- git
  use 'https://github.com/lewis6991/gitsigns.nvim'                               -- git decoration for buffers
  use 'https://github.com/tpope/vim-fugitive'                                    -- Git
  use 'https://github.com/tpope/vim-rhubarb'                                     -- Adds Github to futitive, e.g. Gbrowse


  -- completion
  use 'https://github.com/hrsh7th/nvim-cmp'
  use 'https://github.com/hrsh7th/cmp-nvim-lsp'
  use 'https://github.com/hrsh7th/cmp-buffer'
  use 'https://github.com/hrsh7th/cmp-path'
  use 'https://github.com/hrsh7th/cmp-cmdline'
  use 'https://github.com/andersevenrud/cmp-tmux'


  -- snippets
  use 'https://github.com/L3MON4D3/LuaSnip'
  use 'https://github.com/saadparwaiz1/cmp_luasnip'
  use 'https://github.com/rafamadriz/friendly-snippets'


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

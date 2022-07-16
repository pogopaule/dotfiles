local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- TODO: checkout plugins
-- https://github.com/jamestthompson3/nvim-remote-containers remote developing like in vscode
-- https://github.com/pwntester/octo.nvim github
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/jose-elias-alvarez/typescript.nvim additional lsp features for typescript, mainly imports related
-- https://github.com/ms-jpq/coq_nvim alternative to vim-cmp?
-- https://github.com/ms-jpq/chadtree alternative to nvim-tree?
-- https://github.com/danymat/neogen generate annotations and documentation
-- https://github.com/anuvyklack/hydra.nvim some keybinding stuff
-- https://github.com/ThePrimeagen/harpoon naviage favorite locations

return packer.startup(function(use)
  -- basics
  use 'wbthomason/packer.nvim'                                -- Have packer manage itself
  use 'nvim-lua/popup.nvim'                                   -- Popup API from vim in neovim
  use 'nvim-lua/plenary.nvim'                                 -- Lua functions
  use 'antoinemadec/FixCursorHold.nvim'

  -- layout / windows
  use 'kyazdani42/nvim-tree.lua'                              -- File Explorer
  use 'goolord/alpha-nvim'                                    -- Start screen
  use 'nvim-lualine/lualine.nvim'                             -- Status bar
  use 'kyazdani42/nvim-web-devicons'                          -- Icon font
  use 'EdenEast/nightfox.nvim'                                -- nightfox theme
  use 'akinsho/bufferline.nvim'                               -- A bufferline
  use 'kazhala/close-buffers.nvim'                            -- helpers to close buffers
  use 'nvim-telescope/telescope.nvim'                         -- Find, Filter, Preview, Pick
  use 'nvim-telescope/telescope-ui-select.nvim'               -- use telescope to select options

  -- misc
  use 'godlygeek/tabular'                                     -- Tabularize
  use 'ntpeters/vim-better-whitespace'                        -- Show unwanted whitespaces
  use 'christoomey/vim-tmux-navigator'                        -- Seamless jumping between vim and tmux
  use 'airblade/vim-rooter'                                   -- Changes Vim working directory to project root
  use 'karb94/neoscroll.nvim'                                 -- smooth scrolling
  use 'ggandor/leap.nvim'                                     -- Jump in text
  use 'mbbill/undotree'                                       -- show undotree
  use 'folke/which-key.nvim'                                  -- shows what to type after a prefix
  use { 'renerocksai/telekasten.nvim',                        -- zettelkasten
    requires = { { 'renerocksai/calendar-vim' } }
  }
  use 'dbeniamine/cheat.sh-vim'


  -- coding
  use 'editorconfig/editorconfig-vim'                         -- editorconfig integration
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Nvim Treesitter configurations and abstraction layer
  use 'andymass/vim-matchup'                                  -- extends %
  use 'kylechui/nvim-surround'                                -- easily surround with brackets
  use 'numToStr/Comment.nvim'                                 -- Comments
  use 'JoosepAlviste/nvim-ts-context-commentstring'           -- Context aware comments
  use 'norcalli/nvim-colorizer.lua'                           -- Colorize hex colors
  use 'windwp/nvim-autopairs'                                 -- Insert matching quote, brackets, etc.
  use 'mattn/emmet-vim'                                       -- Emmet
  use 'folke/todo-comments.nvim'                              -- Highlight, list and search todo comments
  use 'preservim/vim-markdown'                                -- Markdown
  use 'ThePrimeagen/refactoring.nvim'                         -- Refactoring
  use 'nvim-treesitter/nvim-treesitter-textobjects'           -- Text objects like functions and variables
  use 'davidgranstrom/nvim-markdown-preview'                  -- Preview markdown, requires live-preview and pandoc to be installed
  use 'jpalardy/vim-slime'                                    -- Send line to tmux

  -- testing
  use 'nvim-neotest/neotest'
  use 'nvim-neotest/neotest-python'

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'theHamsta/nvim-dap-virtual-text'

  -- LSP
  use 'neovim/nvim-lspconfig'                                 -- LSP support
  use 'tami5/lspsaga.nvim'                                    -- The neovim language-server-client UI
  use 'onsails/lspkind-nvim'                                  -- vscode-like pictograms for neovim lsp completion items
  use 'jose-elias-alvarez/null-ls.nvim'                       -- LSP bridge for linters and others
  use 'williamboman/nvim-lsp-installer'                       -- Easy installation of LSP servers
  use 'ray-x/lsp_signature.nvim'                              -- LSP signature hint as you type
  use 'b0o/schemastore.nvim'                                  -- JSON schema awareness
  use 'j-hui/fidget.nvim'                                     -- Show LSP progress
  use 'folke/trouble.nvim'                                    -- Nicer diagnostics

  -- git
  use 'lewis6991/gitsigns.nvim'                               -- git decoration for buffers
  use 'tpope/vim-fugitive'                                    -- Git
  use 'tpope/vim-rhubarb'                                     -- Adds Gbrowse
  use 'junegunn/gv.vim'                                       -- browse git history
  use {
    'ldelossa/gh.nvim',                                       -- Code reviews in vim
    requires = { { 'ldelossa/litee.nvim' } }
  }

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'andersevenrud/cmp-tmux'

  -- snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'rafamadriz/friendly-snippets'

  -- open file in github
  use 'tyru/open-browser.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

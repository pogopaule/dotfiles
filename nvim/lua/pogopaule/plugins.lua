-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerSync',
  pattern = 'plugins.lua',
  group = group,
})


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

local packer_util = require('packer.util')

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return packer_util.float { border = 'rounded' }
    end,
  },
  -- snapshot = 'current_packer_snapshot.json',
  -- snapshot_path = vim.fn.stdpath('config'),
}


-- TODO: checkout plugins
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/jose-elias-alvarez/typescript.nvim additional lsp features for typescript, mainly imports related
-- https://github.com/ms-jpq/coq_nvim alternative to vim-cmp?
-- https://github.com/ms-jpq/chadtree alternative to nvim-tree?
-- https://github.com/danymat/neogen generate annotations and documentation
-- https://github.com/ThePrimeagen/harpoon naviage favorite locations
-- https://github.com/kevinhwang91/nvim-ufo nicer folds
-- https://github.com/mizlan/iswap.nvim swapping powered by treesitter
-- https://github.com/Vonr/align.nvim replace Tabularize?
-- https://github.com/lukas-reineke/headlines.nvim better markdown headline highlights
-- https://github.com/jakewvincent/mkdnflow.nvim
-- https://github.com/andythigpen/nvim-coverage display test coverage


return packer.startup(function(use)
  -- INCUBATOR: not sure if these plugins should be kept
  use 'https://github.com/dkarter/bullets.vim' -- fixes indentation problems with bullet lists

  use 'https://github.com/nvim-treesitter/playground' -- treesitter playground, show syntax tree

  use { 'https://github.com/ldelossa/gh.nvim', -- Code reviews in vim
    requires = { { 'https://github.com/ldelossa/litee.nvim' } }
  }

  use 'https://github.com/dbeniamine/cheat.sh-vim' -- cheat.sh integration

  use { 'https://github.com/pwntester/octo.nvim', config = function() require('octo').setup() end } -- github integration

  use { 'https://github.com/potamides/pantran.nvim', config = function() -- translate text
    require('pantran').setup {
      default_engine = 'deepl',
      engines = { deepl = { default_target = 'de' } },
    }
  end }

  use { 'https://github.com/monaqa/dial.nvim', config = function() -- enhanced inc/dec
    local augend = require("dial.augend")
    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.constant.alias.bool,
      },
    }
  end }

  -- use 'https://github.com/editorconfig/editorconfig-vim'                         -- editorconfig integration
  -- use 'https://github.com/jamestthompson3/nvim-remote-containers'                -- use vscode's container definitions in nvim
  -- use 'https://github.com/dstein64/vim-startuptime'                              -- measure startup time



  -- basics
  use 'https://github.com/wbthomason/packer.nvim' -- Have packer manage itself
  use 'https://github.com/nvim-lua/popup.nvim' -- Popup API from vim in neovim
  use 'https://github.com/nvim-lua/plenary.nvim' -- Lua functions
  use 'https://github.com/antoinemadec/FixCursorHold.nvim' -- fix CursorHold performance



  -- layout / windows
  use { 'https://github.com/kyazdani42/nvim-tree.lua', config = function() -- File Explorer
    require('nvim-tree').setup({
      filters = {
        dotfiles = true,
      },
      git = {
        ignore = false,
      },
      view = {
        mappings = {
          list = {
            { key = { 'cd' }, action = 'cd' },
          }
        },
        width = 50,
      }
    })
    vim.g.nvim_tree_special_files = {}
  end }

  use { 'https://github.com/goolord/alpha-nvim', config = function() -- Start screen
    require('alpha').setup(require('alpha.themes.startify').config)
  end }

  use { 'https://github.com/nvim-lualine/lualine.nvim', config = function() -- Status bar
    require('lualine').setup({
      options = {
        disabled_filetypes = {
          statusline = { 'NvimTree' },
        },
      },
    })
  end }

  use { 'https://github.com/kyazdani42/nvim-web-devicons', config = function() require('nvim-web-devicons').setup() end } -- Icon font

  use { 'https://github.com/EdenEast/nightfox.nvim', run = ':NightfoxCompile', } -- nightfox theme

  use { 'https://github.com/akinsho/bufferline.nvim', config = function()
    require('bufferline').setup({ -- buffers as tabs
      options = {
        offsets = { {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left'
        } }
      }
    })
  end }

  use { 'https://github.com/kazhala/close-buffers.nvim', config = function() require('close_buffers').setup() end } -- helpers to close buffers, used by bufferline

  use 'https://github.com/rcarriga/nvim-notify' -- popup messages



  -- moving around
  use { 'https://github.com/ggandor/leap.nvim', config = function() require('leap').add_default_mappings() end } -- Jump in text

  use 'https://github.com/nvim-telescope/telescope.nvim' -- Find, Filter, Preview, Pick

  use 'https://github.com/nvim-telescope/telescope-ui-select.nvim' -- use telescope to select options



  -- misc
  use 'https://github.com/godlygeek/tabular' -- Tabularize

  use { 'https://github.com/zakharykaplan/nvim-retrail', config = function() -- Show and remove unwanted whitespaces
    require('retrail').setup {
      hlgroup = 'Substitute',
      filetype = {
        strict = false,
      },
      trim = {
        blanklines = true,
      }
    }
  end }

  use 'https://github.com/christoomey/vim-tmux-navigator' -- Seamless jumping between vim and tmux

  use 'https://github.com/airblade/vim-rooter' -- Changes Vim working directory to project root

  use { 'https://github.com/karb94/neoscroll.nvim', config = function() -- smooth scrolling
    require('neoscroll').setup({
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    })
  end }

  use { 'https://github.com/folke/which-key.nvim', config = function() require('which-key').setup() end } -- shows what to type after a prefix

  use { 'https://github.com/tyru/open-browser.vim', config = function() -- open url or word as search in browser
    vim.cmd([[
      " disable netrw's gx mapping.
      let g:netrw_nogx = 1
      let g:openbrowser_default_search = 'duckduckgo'
      ]])
  end }

  use 'http://github.com/lewis6991/impatient.nvim' -- speed up startup



  -- coding
  use { 'https://github.com/nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Nvim Treesitter configurations and abstraction layer

  use 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' -- Text objects like functions and variables

  use 'https://github.com/andymass/vim-matchup' -- extends %

  use 'https://github.com/kylechui/nvim-surround' -- easily surround with brackets

  use { 'https://github.com/numToStr/Comment.nvim', config = require('Comment').setup() } -- Comments

  use { 'https://github.com/norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end } -- Colorize hex colors

  use { 'https://github.com/windwp/nvim-autopairs', config = function() -- Insert matching quote, brackets, etc.
    require('nvim-autopairs').setup({ fast_wrap = {} })
    -- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end }

  use { 'https://github.com/folke/todo-comments.nvim', config = function() require('todo-comments').setup() end } -- Highlight, list and search todo comments

  use 'https://github.com/preservim/vim-markdown' -- Markdown

  use { 'https://github.com/ThePrimeagen/refactoring.nvim', config = function() require('refactoring').setup() end } -- Refactoring

  use 'https://github.com/davidgranstrom/nvim-markdown-preview' -- Preview markdown, requires live-preview and pandoc to be installed

  use { 'https://github.com/jpalardy/vim-slime', config = function() -- Send line to tmux
    vim.cmd([[
    let g:slime_target = "tmux"
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
    let g:slime_dont_ask_default = 1
    ]])
  end }

  use 'https://github.com/b0o/schemastore.nvim' -- JSON schema awareness, gives LSP completions for e.g. package.json

  use { 'https://github.com/lukas-reineke/indent-blankline.nvim', config = function() -- indentation guides
    require("indent_blankline").setup { show_current_context = true }
  end }

  use { 'https://github.com/andrewferrier/debugprint.nvim', config = function() require('debugprint').setup() end } -- print() debugging



  -- testing
  use 'https://github.com/nvim-neotest/neotest'

  use 'https://github.com/nvim-neotest/neotest-python'



  -- debugging
  use 'https://github.com/mfussenegger/nvim-dap'

  use 'https://github.com/rcarriga/nvim-dap-ui'

  use 'https://github.com/nvim-telescope/telescope-dap.nvim'

  use 'https://github.com/theHamsta/nvim-dap-virtual-text'

  use 'https://github.com/mxsdev/nvim-dap-vscode-js'

  use { 'microsoft/vscode-js-debug', opt = true,
    -- run = "npm install --legacy-peer-deps && npm run compile"
  }



  -- LSP
  use 'https://github.com/neovim/nvim-lspconfig' -- LSP support

  use 'https://github.com/glepnir/lspsaga.nvim' -- The neovim language-server-client UI

  use 'https://github.com/onsails/lspkind-nvim' -- vscode-like pictograms for neovim lsp completion items

  use 'https://github.com/jose-elias-alvarez/null-ls.nvim' -- LSP bridge for linters and others

  use 'https://github.com/ray-x/lsp_signature.nvim' -- LSP signature hint as you type

  use { 'https://github.com/j-hui/fidget.nvim', config = function() require('fidget').setup() end } -- Show LSP progress

  use { 'https://github.com/folke/trouble.nvim', config = function() require('trouble').setup() end } -- Nicer diagnostics

  use 'https://github.com/mfussenegger/nvim-jdtls' -- LSP and DAP for java



  -- git
  use { 'https://github.com/lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end } -- git decoration for buffers

  use 'https://github.com/tpope/vim-fugitive' -- Git

  use 'https://github.com/tpope/vim-rhubarb' -- Adds Github to futitive, e.g. Gbrowse

  use { 'https://github.com/ruifm/gitlinker.nvim', config = function() require('gitlinker').setup() end } -- create github permalink via <leader>gy



  -- completion
  use 'https://github.com/hrsh7th/nvim-cmp'

  use 'https://github.com/hrsh7th/cmp-nvim-lsp'

  use 'https://github.com/hrsh7th/cmp-buffer'

  use 'https://github.com/hrsh7th/cmp-path'

  use 'https://github.com/hrsh7th/cmp-cmdline'

  -- use 'https://github.com/andersevenrud/cmp-tmux'



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

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


-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- local group = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   command = 'source <afile> | PackerSync',
--   pattern = 'plugins.lua',
--   group = group,
-- })

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

return packer.startup(function(use)
  -- Incubator ###############################

  -- ChatGPT
  use({
    "jackMort/ChatGPT.nvim", config = function() require("chatgpt").setup() end,
    requires = {
      "MunifTanjim/nui.nvim",
    }
  })

  -- undo tree in telescope
  use {
    'debugloop/telescope-undo.nvim', config = function()
      require('telescope').load_extension('undo')
    end,
  }
  -- better folding
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = function()

    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

    -- Option 3: treesitter as a main provider instead
    -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
    -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })
  end }

  -- fixes indentation problems with bullet lists
  use 'https://github.com/dkarter/bullets.vim'

  -- treesitter playground, show syntax tree
  use 'https://github.com/nvim-treesitter/playground'

  -- cheat.sh integration
  use 'https://github.com/dbeniamine/cheat.sh-vim'

  -- github integration
  use { 'https://github.com/pwntester/octo.nvim', config = function() require('octo').setup() end }

  -- note taking
  use 'https://github.com/renerocksai/telekasten.nvim'

  -- -- editorconfig integration
  -- use 'https://github.com/editorconfig/editorconfig-vim'

  -- -- use vscode's container definitions in nvim
  -- use 'https://github.com/jamestthompson3/nvim-remote-containers'

  -- -- measure startup time
  -- use 'https://github.com/dstein64/vim-startuptime'

  -- Code reviews in vim
  use { 'https://github.com/ldelossa/gh.nvim',
    requires = { { 'https://github.com/ldelossa/litee.nvim' } }
  }

  -- translate text
  use { 'https://github.com/potamides/pantran.nvim', config = function()
    require('pantran').setup {
      default_engine = 'deepl',
      engines = { deepl = { default_target = 'de' } },
    }
  end }

  -- enhanced inc/dec
  use { 'https://github.com/monaqa/dial.nvim', config = function()
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



  -- Basics #################################

  -- Have packer manage itself
  use 'https://github.com/wbthomason/packer.nvim'

  -- Popup API from vim in neovim
  use 'https://github.com/nvim-lua/popup.nvim'

  -- Lua functions
  use 'https://github.com/nvim-lua/plenary.nvim'

  -- fix CursorHold performance
  use 'https://github.com/antoinemadec/FixCursorHold.nvim'


  -- Layout and Windows #####################

  -- helpers to close buffers, used by bufferline
  use { 'https://github.com/kazhala/close-buffers.nvim', config = function() require('close_buffers').setup() end }

  -- Icon font
  use { 'https://github.com/kyazdani42/nvim-web-devicons', config = function() require('nvim-web-devicons').setup() end }

  -- File Explorer
  use { 'https://github.com/kyazdani42/nvim-tree.lua', config = function()
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
      },
      renderer = {
        special_files = {},
      },
    })
  end }

  -- Start screen
  use { 'https://github.com/goolord/alpha-nvim', config = function()
    require('alpha').setup(require('alpha.themes.startify').config)
  end }

  -- Status bar
  use { 'https://github.com/nvim-lualine/lualine.nvim', config = function()
    require('lualine').setup({
      options = {
        disabled_filetypes = {
          statusline = { 'NvimTree' },
        },
      },
    })
  end }

  -- nightfox theme
  use { 'https://github.com/EdenEast/nightfox.nvim', run = ':NightfoxCompile', config = function()
    local nightfox = require('nightfox')
    nightfox.setup({
      options = {
        styles = {
          comments = 'italic',
          keywords = 'bold',
        },
      }
    })
    if os.getenv("THEME") == "light" then
      vim.cmd('colorscheme dayfox')
    else
      vim.cmd('colorscheme nordfox')
    end
  end }

  -- buffers as tabs
  use { 'https://github.com/akinsho/bufferline.nvim', config = function()
    require('bufferline').setup({
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

  -- popup messages
  use { 'https://github.com/rcarriga/nvim-notify', config = function()
    vim.notify = require("notify")
  end }



  -- Moving Around ################################

  -- Jump in text
  use { 'https://github.com/ggandor/leap.nvim', config = function() require('leap').add_default_mappings() end }

  -- Find, Filter, Preview, Pick
  use 'https://github.com/nvim-telescope/telescope.nvim'

  -- use telescope to select options
  use { 'https://github.com/nvim-telescope/telescope-ui-select.nvim', config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown {} }
      }
    }
    -- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
    require('telescope').load_extension('ui-select')
  end }



  -- Misc ########################################

  -- Tabularize
  use 'https://github.com/godlygeek/tabular'

  -- speed up startup
  use 'http://github.com/lewis6991/impatient.nvim'

  -- Seamless jumping between vim and tmux
  use 'https://github.com/christoomey/vim-tmux-navigator'

  -- Changes Vim working directory to project root
  use 'https://github.com/airblade/vim-rooter'

  -- shows what to type after a prefix
  use { 'https://github.com/folke/which-key.nvim', config = function() require('which-key').setup() end }

  -- Show and remove unwanted whitespaces
  use { 'https://github.com/zakharykaplan/nvim-retrail', config = function()
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

  -- smooth scrolling
  use { 'https://github.com/karb94/neoscroll.nvim', config = function()
    require('neoscroll').setup({
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    })
  end }

  -- open url or word as search in browser
  use { 'https://github.com/tyru/open-browser.vim', config = function()
    vim.cmd([[
      " disable netrw's gx mapping.
      let g:netrw_nogx = 1
      let g:openbrowser_default_search = 'duckduckgo'
    ]])
  end }



  -- Coding #########################################

  -- Nvim Treesitter configurations and abstraction layer
  use { 'https://github.com/nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Text objects like functions and variables
  use 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'

  -- extends %
  use 'https://github.com/andymass/vim-matchup'

  -- Comments
  use { 'https://github.com/numToStr/Comment.nvim', config = require('Comment').setup() }

  -- Colorize hex colors
  use { 'https://github.com/norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }

  -- Highlight, list and search todo comments
  use { 'https://github.com/folke/todo-comments.nvim', config = function() require('todo-comments').setup() end }

  -- Markdown
  use 'https://github.com/preservim/vim-markdown'

  -- Refactoring
  use { 'https://github.com/ThePrimeagen/refactoring.nvim', config = function() require('refactoring').setup() end }

  -- Preview markdown, requires live-preview and pandoc to be installed
  use 'https://github.com/davidgranstrom/nvim-markdown-preview'

  -- JSON schema awareness, gives LSP completions for e.g. package.json
  use 'https://github.com/b0o/schemastore.nvim'

  use 'https://github.com/nvim-neotest/neotest-python'

  -- print() debugging
  use { 'https://github.com/andrewferrier/debugprint.nvim', config = function() require('debugprint').setup() end }

  -- split or join blocks powered by treesitter
  use({ 'Wansmer/treesj', config = function() require('treesj').setup({ use_default_keymaps = false }) end })

  -- easily surround with brackets
  use { 'https://github.com/kylechui/nvim-surround', config = function()
    require('nvim-surround').setup()
  end }

  -- Insert matching quote, brackets, etc.
  use { 'https://github.com/windwp/nvim-autopairs', config = function()
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

  -- Send line to tmux
  use { 'https://github.com/jpalardy/vim-slime', config = function()
    vim.cmd([[
    let g:slime_target = "tmux"
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
    let g:slime_dont_ask_default = 1
    ]])
  end }

  -- indentation guides
  use { 'https://github.com/lukas-reineke/indent-blankline.nvim', config = function()
    require("indent_blankline").setup { show_current_context = true }
  end }

  use { 'https://github.com/nvim-neotest/neotest', config = function()
    require('neotest').setup({
      adapters = { require('neotest-python')({}) },
    })
  end }



  -- LSP ############################################

  -- LSP support
  use 'https://github.com/neovim/nvim-lspconfig'

  -- The neovim language-server-client UI
  use 'https://github.com/glepnir/lspsaga.nvim'

  -- vscode-like pictograms for neovim lsp completion items
  use 'https://github.com/onsails/lspkind-nvim'

  -- LSP bridge for linters and others
  use 'https://github.com/jose-elias-alvarez/null-ls.nvim'

  -- LSP signature hint as you type
  use 'https://github.com/ray-x/lsp_signature.nvim'

  -- Show LSP progress
  use { 'https://github.com/j-hui/fidget.nvim', config = function() require('fidget').setup() end }

  -- Nicer diagnostics
  use { 'https://github.com/folke/trouble.nvim', config = function() require('trouble').setup() end }

  -- LSP and DAP for java
  use 'https://github.com/mfussenegger/nvim-jdtls'



  -- Debugging ######################################

  use 'https://github.com/mfussenegger/nvim-dap'
  use 'https://github.com/rcarriga/nvim-dap-ui'
  use { 'https://github.com/nvim-telescope/telescope-dap.nvim', config = function()
    require('telescope').load_extension('dap')
  end }
  use 'https://github.com/theHamsta/nvim-dap-virtual-text'
  use 'https://github.com/mxsdev/nvim-dap-vscode-js'
  use { 'microsoft/vscode-js-debug', opt = true,
    -- run = "npm install --legacy-peer-deps && npm run compile"
  }



  -- Git ############################################

  -- git decoration for buffers
  use { 'https://github.com/lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }

  -- Git
  use 'https://github.com/tpope/vim-fugitive'

  -- Adds Github to futitive, e.g. Gbrowse
  use 'https://github.com/tpope/vim-rhubarb'

  -- create github permalink via <leader>gy
  use { 'https://github.com/ruifm/gitlinker.nvim', config = function() require('gitlinker').setup() end }



  -- Completion ########################################

  use 'https://github.com/hrsh7th/nvim-cmp'
  use 'https://github.com/hrsh7th/cmp-nvim-lsp'
  use 'https://github.com/hrsh7th/cmp-buffer'
  use 'https://github.com/hrsh7th/cmp-path'
  use 'https://github.com/hrsh7th/cmp-cmdline'
  -- use 'https://github.com/andersevenrud/cmp-tmux'



  -- Snippets ##########################################

  use 'https://github.com/L3MON4D3/LuaSnip'
  use 'https://github.com/saadparwaiz1/cmp_luasnip'
  use 'https://github.com/rafamadriz/friendly-snippets'




  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

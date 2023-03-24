return {

  -- Icon font
  {
    'https://github.com/kyazdani42/nvim-web-devicons',
    event = 'VeryLazy',
    config = true,
  },

  -- File Explorer
  {
    'https://github.com/kyazdani42/nvim-tree.lua',
    keys = {
      { '<leader>tn', '<CMD>NvimTreeToggle<CR>', desc = 'Nvim Tree' },
      { '<leader>N', '<CMD>NvimTreeFindFile<CR>', desc = 'Find File in Nvim Tree' },
    },
    config = {
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
    },
  },

  -- Start screen
  {
    'https://github.com/goolord/alpha-nvim',
    lazy = false,
    config = function()
      local startify = require('alpha.themes.startify')
      startify.section.header.val = {
        [[                                                     ]],
        [[                                                     ]],
        [[                                                     ]],
        [[                                                     ]],
        [[                                                     ]],
        [[                                                     ]],
      }
      require('alpha').setup(startify.config)
    end
  },

  -- Status bar
  {
    'https://github.com/nvim-lualine/lualine.nvim',
    lazy = false,
    config = {
      options = {
        disabled_filetypes = {
          statusline = { 'NvimTree' },
        },
      },
    },
  },

  -- popup messages
  {
    'https://github.com/rcarriga/nvim-notify',
    lazy = false,
    config = function()
      local notify = require('notify')
      vim.notify = notify
      notify.setup({
        timeout = 1000,
      })
    end,
  },

  -- indentation guides
  {
    'https://github.com/lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = { show_current_context = true },
  },
}

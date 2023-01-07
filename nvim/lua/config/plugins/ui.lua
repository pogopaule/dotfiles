return {
  -- helpers to close buffers, used by bufferline
  {
    'https://github.com/kazhala/close-buffers.nvim',
    event = 'VeryLazy',
    config = true,
  },

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
      { '<leader>N', '<CMD>NvimTreeToggle<CR>', desc = 'Toggle Nvim Tree' },
      { '<leader>n', '<CMD>NvimTreeFindFile<CR>', desc = 'Find File in Nvim Tree' },
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
    event = 'VeryLazy',
    config = {
      options = {
        disabled_filetypes = {
          statusline = { 'NvimTree' },
        },
      },
    },
  },

  -- buffers as tabs
  {
    'https://github.com/akinsho/bufferline.nvim',
    event = 'BufAdd',

    config = function()
      require('bufferline').setup({
        options = {
          always_show_bufferline = false,
          offsets = { {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left'
          } }
        }
      })
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map('n', '<A-h>', '<CMD>BufferLineCyclePrev<CR>', opts)
      map('n', '<A-l>', '<CMD>BufferLineCycleNext<CR>', opts)
      map('i', '<A-h>', '<CMD>BufferLineCyclePrev<CR>', opts)
      map('i', '<A-l>', '<CMD>BufferLineCycleNext<CR>', opts)
    end,
  },

  -- popup messages
  {
    'https://github.com/rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  },

  -- indentation guides
  {
    'https://github.com/lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = { show_current_context = true },
  },
}

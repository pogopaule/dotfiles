return {
  -- Highlight word under cursor
  {
    "https://github.com/RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require('illuminate').configure({
        filetypes_denylist = {
          -- `lua = vim.bo.filetype` to get the filetype of the current buffer
          'NvimTree',
          'Outline',
          'aerial-nav',
          'aerial',
        },
      })
    end,
  },
  {
    'https://github.com/folke/zen-mode.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'ZenMode' },
    config = {
      window = {
        width = 150,
      },
      plugins = {
        twilight = { enabled = true }
      }
    },
    dependencies = {
      { 'https://github.com/folke/twilight.nvim' }
    }
  },

  -- Icon font
  {
    'https://github.com/kyazdani42/nvim-web-devicons',
    event = 'VeryLazy',
    config = true,
  },

  -- Start screen
  {
    'https://github.com/goolord/alpha-nvim',
    lazy = false,
    config = function()
      local startify = require('alpha.themes.startify')
      startify.section.header.val = {}
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
    main = 'ibl',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
}

return {
  -- Lua functions used by other plugins
  { url = 'https://github.com/nvim-lua/plenary.nvim' },

  -- fix CursorHold performance
  {
    url = 'https://github.com/antoinemadec/FixCursorHold.nvim',
    lazy = false,
  },

  -- Tabularize
  {
    url = 'https://github.com/godlygeek/tabular',
    cmd = 'Tabularize',
  },

  -- Changes Vim working directory to project root
  {
    url = 'https://github.com/airblade/vim-rooter',
    event = 'VeryLazy',
  },

  -- Show and remove unwanted whitespaces
  { url = 'https://github.com/zakharykaplan/nvim-retrail',
    event = 'BufReadPost',
    config = {
      hlgroup = 'Substitute',
      filetype = {
        strict = false,
      },
      trim = {
        blanklines = true,
      }
    },
  },

  -- smooth scrolling
  {
    url = 'https://github.com/karb94/neoscroll.nvim',
    event = 'BufReadPost',
    config = {
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    },
  },

  -- open url or word as search in browser
  {
    url = 'https://github.com/tyru/open-browser.vim',
    keys = {
      { 'gx', '<plug>(openbrowser-smart-search)', desc = 'Open URL Under Cursor' },
      { 'gx', '<plug>(openbrowser-smart-search)', mode = 'v', desc = 'Open selection in DDG' },
    },
  },
}

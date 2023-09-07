return {
  -- Lua functions used by other plugins
  { 'https://github.com/nvim-lua/plenary.nvim' },

  -- fix CursorHold performance
  {
    'https://github.com/antoinemadec/FixCursorHold.nvim',
    lazy = false,
  },

  -- Tabularize
  {
    'https://github.com/godlygeek/tabular',
    cmd = 'Tabularize',
  },

  -- Changes Vim working directory to project root
  {
    'https://github.com/airblade/vim-rooter',
    event = 'VeryLazy',
  },

  -- Show and remove unwanted whitespaces
  { 'https://github.com/zakharykaplan/nvim-retrail',
    event = { 'BufReadPost', 'BufNewFile' },
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
    'https://github.com/karb94/neoscroll.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = {
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    },
  },

  -- open url or word as search in browser
  {
    'https://github.com/tyru/open-browser.vim',
    keys = {
      { 'gx', '<plug>(openbrowser-smart-search)', desc = 'Open URL Under Cursor' },
      { 'gx', '<plug>(openbrowser-smart-search)', mode = 'v',                    desc = 'Open selection in DDG' },
    },
  },
}

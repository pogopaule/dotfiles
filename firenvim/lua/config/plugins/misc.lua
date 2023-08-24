return {
  {
    'https://github.com/glacambre/firenvim',
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end
  },

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
      { 'gx', '<plug>(openbrowser-smart-search)', mode = 'v', desc = 'Open selection in DDG' },
    },
  },
}

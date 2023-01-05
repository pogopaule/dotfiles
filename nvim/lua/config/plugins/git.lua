return {
  -- git decoration for buffers
  {
    'https://github.com/lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true,
  },

  -- create github permalink via <leader>gy
  {
    'https://github.com/ruifm/gitlinker.nvim',
    config = true,
  },
}

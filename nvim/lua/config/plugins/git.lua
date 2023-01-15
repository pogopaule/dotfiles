return {
  -- git decoration for buffers
  {
    url = 'https://github.com/lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true,
  },

  -- create github permalink via <leader>gy
  {
    url = 'https://github.com/ruifm/gitlinker.nvim',
    config = true,
  },
}

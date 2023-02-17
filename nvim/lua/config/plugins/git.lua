return {
  -- git decoration for buffers
  {
    'https://github.com/lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- create github permalink via <leader>gy
  {
    'https://github.com/ruifm/gitlinker.nvim',
    config = true,
  },

  {
    'https://github.com/tpope/vim-fugitive',
    cmd = { 'G', 'Git' },
  },
}

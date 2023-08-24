return {
  -- git decoration for buffers
  {
    'https://github.com/lewis6991/gitsigns.nvim',
    keys = {
      { '<leader>gr',  '<CMD>Gitsigns reset_hunk<CR>',   desc = 'Reset Hunk' },
      { '<leader>gbl', '<CMD>Gitsigns blame_line<CR>',   desc = 'Blame Line' },
      { '<leader>gp',  '<CMD>Gitsigns preview_hunk<CR>', desc = 'Preview Hunk' },
      { '<leader>gn',  '<CMD>Gitsigns next_hunk<CR>',    desc = 'Next Hunk' },
      { '<leader>gN',  '<CMD>Gitsigns prev_hunk<CR>',    desc = 'Previous Hunk' },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- create github permalink via <leader>gy
  {
    'https://github.com/ruifm/gitlinker.nvim',
    keys = {
      { '<leader>gy', '<CMD>lua require("gitlinker").get_buf_range_url("n")<CR>', desc = 'Github Link' },
    },
    config = true,
  },

  {
    'https://github.com/tpope/vim-fugitive',
    cmd = { 'G', 'Git' },
  },
}

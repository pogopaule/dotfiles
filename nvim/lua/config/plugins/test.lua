return {
  {
    'https://github.com/nvim-neotest/neotest',
    dependencies = {
      { 'https://github.com/nvim-neotest/neotest-python' },
      { 'https://github.com/nvim-neotest/nvim-nio' }
    },
    ft = { 'python' },
    keys = {
      { '<leader>TT', '<CMD>write | lua require("neotest").run.run()<CR>',                   desc = 'Nearest' },
      { '<leader>Tf', '<CMD>write | lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'File' },
      { '<leader>Ta', '<CMD>lua require("neotest").run.attach()<CR>',                        desc = 'Attach' },
      { '<leader>Tx', '<CMD>lua require("neotest").run.stop()<CR>',                          desc = 'Stop Nearest' },
      { '<leader>Ts', '<CMD>lua require("neotest").summary.toggle()<CR>',                    desc = 'Toggle Summary' },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            python = "python",
            runner = "pytest",
          }),
        },
        quickfix = {
          open = false,
        },
      })
    end,
  },
}

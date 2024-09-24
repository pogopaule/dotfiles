return {
  {
    'https://github.com/folke/flash.nvim',
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
        char = {
          keys = {}, -- this removes ',' from the list, which I use as the leader key, also removes f and t which is annoying with flash
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
    },
  },

  -- Seamless jumping between vim and tmux
  {
    'https://github.com/alexghergh/nvim-tmux-navigation',
    keys = {
      {
        '<C-h>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<CR>",
        desc = 'Tmux Left',
        mode = { 'n', 'v', 'i' }
      },
      {
        '<C-j>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<CR>",
        desc = 'Tmux Down',
        mode = { 'n', 'v', 'i' }
      },
      {
        '<C-k>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<CR>",
        desc = 'Tmux Up',
        mode = { 'n', 'v', 'i' }
      },
      {
        '<C-l>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<CR>",
        desc = 'Tmux Right',
        mode = { 'n', 'v', 'i' }
      },
    },
    config = function()
      require('nvim-tmux-navigation').setup({})
    end
  },

}

return {
  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      {
        "<C-h>",
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<CR>",
        desc = "Tmux Left",
        mode = { "n", "v", "i" },
      },
      {
        "<C-j>",
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<CR>",
        desc = "Tmux Down",
        mode = { "n", "v", "i" },
      },
      {
        "<C-k>",
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<CR>",
        desc = "Tmux Up",
        mode = { "n", "v", "i" },
      },
      {
        "<C-l>",
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<CR>",
        desc = "Tmux Right",
        mode = { "n", "v", "i" },
      },
    },
    config = true,
  },
}

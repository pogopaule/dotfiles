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

  -- Send line to tmux
  {
    "jpalardy/vim-slime",
    event = "VeryLazy",
    init = function()
      vim.cmd([[let g:slime_no_mappings = 1]])
    end,
    config = function()
      local map = vim.keymap.set
      map("x", "<bar>", "<Plug>SlimeRegionSend", {})
      map("n", "<bar>", "<Plug>SlimeParagraphSend", {})

      vim.cmd([[
          let g:slime_target = "tmux"
          let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
          let g:slime_dont_ask_default = 1
        ]])
    end,
  },
}

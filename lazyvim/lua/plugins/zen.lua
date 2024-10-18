return {
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = {
      {
        "<leader>uz",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Toggle Zen Mode",
      },
    },
    opts = {
      plugins = {
        options = {
          laststatus = 0, -- turn off the statusline in zen mode
        },
        tmux = { enabled = true },
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      treesitter = true,
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
      },
      context = 20,
    },
  },
}

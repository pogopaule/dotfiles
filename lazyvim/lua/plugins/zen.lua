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
}

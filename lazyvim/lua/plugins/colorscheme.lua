return {
  { "EdenEast/nightfox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dawnfox",
    },
  },

  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    opts = {
      update_interval = 3000,
      set_dark_mode = function()
        vim.cmd("colorscheme nordfox")
      end,
      set_light_mode = function()
        vim.cmd("colorscheme dawnfox")
      end,
    },
  },
}

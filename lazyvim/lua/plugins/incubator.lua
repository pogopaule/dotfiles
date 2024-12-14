return {
  {
    "okuuva/auto-save.nvim",
    version = "*", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {},
  },
  {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true, -- default is false
    },
    keys = {
      { "<A-j>", "<cmd>Treewalker Down<CR>", desc = "Treewalker Down" },
      { "<A-k>", "<cmd>Treewalker Up<CR>", desc = "Treewalker Up" },
      { "<A-h>", "<cmd>Treewalker Left<CR>", desc = "Treewalker Left" },
      { "<A-l>", "<cmd>Treewalker Right<CR>", desc = "Treewalker Right" },
    },
  },
}

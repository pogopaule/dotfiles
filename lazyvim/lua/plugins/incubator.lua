return {
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

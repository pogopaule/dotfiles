return {
  -- smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = { "VeryLazy" },
    config = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    },
  },
}

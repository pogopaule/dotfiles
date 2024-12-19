return {

  -- snake_case to camelCase and more
  {
    "johmsalas/text-case.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },

  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", "<cmd>TSJToggle<cr>", desc = "TSJoin Toggle" },
    },
    config = {
      use_default_keymaps = false,
    },
  },
}

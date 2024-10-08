return {

  -- snake_case to camelCase and more
  {
    "johmsalas/text-case.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
      vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
      vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end,
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

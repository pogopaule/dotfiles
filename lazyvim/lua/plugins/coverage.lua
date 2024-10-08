return {
  {
    "andythigpen/nvim-coverage",
    event = "VeryLazy",
    config = {
      signs = {
        covered = { hl = "CoverageCovered", text = "█" },
        uncovered = { hl = "CoverageUncovered", text = "█" },
      },
      highlights = {
        covered = { fg = "#02B40A" }, -- supports style, fg, bg, sp (see :h highlight-gui)
        uncovered = { fg = "#FB1404" },
      },
    },
    keys = {
      { "<leader>tc", desc = "coverage" },
      { "<leader>tcc", "<CMD>Coverage<CR>", desc = "Coverage" },
      { "<leader>tct", "<CMD>CoverageToggle<CR>", desc = "Toggle" },
      { "<leader>tcs", "<CMD>CoverageSummary<CR>", desc = "Summary" },
    },
  },
}

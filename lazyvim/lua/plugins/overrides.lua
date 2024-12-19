---@param increment boolean
---@param g? boolean
local function dial(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
  local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func](group)
end
return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
        },
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right", size = 150 },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><cr>", "<cmd>FzfLua lsp_references<cr>", desc = "LSP References" },
    },
  },
  {
    "folke/which-key.nvim",
    keys = {
      { "<leader>,", desc = "Save file and quit", icon = "" },
    },
  },

  -- rendering breaks in obsidian, also doesn't allow for disabling conceallevel
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },

  {
    "akinsho/bufferline.nvim",
    keys = {
      -- I want to use L and H to move the cursor to the top or bottom of the buffer
      { "<S-h>", false },
      { "<S-l>", false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "nix",
      },
    },
  },
}

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
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = {
          selection = "manual",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        compat = { "obsidian", "obsidian_new", "obsidian_tags" },
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    init = function()
      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      -- override this. see https://github.com/LazyVim/LazyVim/blob/d0c366e4d861b848bdc710696d5311dca2c6d540/lua/lazyvim/plugins/extras/lang/sql.lua#L92
      -- fixes https://github.com/LazyVim/LazyVim/discussions/5232
      vim.g.db_ui_execute_on_save = true
    end,
  },
}

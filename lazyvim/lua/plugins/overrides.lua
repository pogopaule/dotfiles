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
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>se", "<cmd>Telescope spell_suggest<cr>", desc = "Spelling Suggestions" },
      { "<leader><cr>", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      vim.keymap.set("n", "<leader>,", "<cmd>wq<cr>", { desc = "Save file and quit" })
    end,
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
    "zbirenbaum/copilot-cmp",
    opts = function()
      local copilot_toggle = Snacks.toggle({
        name = "Copilot Completion",
        get = function()
          return not require("copilot.client").is_disabled()
        end,
        set = function(state)
          if state then
            require("copilot.command").enable()
          else
            require("copilot.command").disable()
          end
        end,
      }):map("<leader>at")
    end,
  },
}

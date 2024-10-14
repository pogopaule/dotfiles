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
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-i>", function() return dial(true) end, expr = true, desc = "Increment", mode = { "n", "v" } },
      { "<C-x>", function() return dial(false) end, expr = true, desc = "Decrement", mode = { "n", "v" } },
      { "g<C-i>", function() return dial(true, true) end, expr = true, desc = "Increment", mode = { "n", "v" } },
      { "g<C-x>", function() return dial(false, true) end, expr = true, desc = "Decrement", mode = { "n", "v" } },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" },
        -- stylua: ignore
        center = {
          { action = "lua LazyVim.pick()()", desc = " Find File", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
          { action = 'lua LazyVim.pick("oldfiles")()', desc = " Recent Files", icon = " ", key = "r" },
          { action = 'lua LazyVim.pick("live_grep")()', desc = " Find Text", icon = " ", key = "g" },
          { action = "ObsidianQuickSwitch", desc = " Obsidian", icon = " ", key = "o" },
          { action = "lua LazyVim.pick.config_files()()", desc = " Config", icon = " ", key = "c" },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
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
}

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
  -- Use `<tab>` for completion and snippets (supertab).
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.preselect = cmp.PreselectMode.None
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      })
    end,
  },
}

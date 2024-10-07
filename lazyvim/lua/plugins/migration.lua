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

  -- Send line to tmux
  {
    "jpalardy/vim-slime",
    event = "VeryLazy",
    init = function()
      vim.cmd([[let g:slime_no_mappings = 1]])
    end,
    config = function()
      local map = vim.keymap.set
      map("x", "<bar>", "<Plug>SlimeRegionSend", {})
      map("n", "<bar>", "<Plug>SlimeParagraphSend", {})

      vim.cmd([[
          let g:slime_target = "tmux"
          let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
          let g:slime_dont_ask_default = 1
        ]])
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    keys = {
      { "<leader>gy", '<cmd>lua require("gitlinker").get_buf_range_url("n")<cr>', desc = "Github Link" },
    },
    config = true,
  },

  {
    "tomasky/bookmarks.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>m", "", desc = "+bookmarks" },
      { "<leader>mm", '<CMD>lua require("bookmarks").bookmark_toggle()<CR>', desc = "Toggle Bookmark" },
      { "<leader>me", '<CMD>lua require("bookmarks").bookmark_ann()<CR>', desc = "Add Annotation" },
      { "<leader>mc", '<CMD>lua require("bookmarks").bookmark_clean()<CR>', desc = "Clean Bookmarks" },
      { "<leader>mn", '<CMD>lua require("bookmarks").bookmark_next()<CR>', desc = "Next Bookmark" },
      { "<leader>mp", '<CMD>lua require("bookmarks").bookmark_prev()<CR>', desc = "Previous Bookmark" },
      { "<leader>ml", '<CMD>lua require("telescope").extensions.bookmarks.list()<CR>', desc = "List Bookmarks" },
      { "<leader>mx", '<CMD>lua require("bookmarks").bookmark_clear_all()<CR>', desc = "Clear All Bookmarks" },
    },
    config = function()
      require("bookmarks").setup({
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand("$HOME/.bookmarks"), -- bookmarks save file path
        signs = {
          add = {
            text = "",
          },
          ann = {
            text = "",
          },
        },
      })
    end,
  },

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

  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },

  -- Show and remove unwanted whitespaces
  -- {
  --   "zakharykaplan/nvim-retrail",
  --   event = { "BufReadPost", "BufNewFile" },
  --   config = {
  --     hlgroup = "Substitute",
  --     filetype = {
  --       strict = false,
  --     },
  --     trim = {
  --       blanklines = true,
  --     },
  --   },
  -- },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "secondbrain",
          path = "~/secondbrain",
        },
      },
      templates = {
        subdir = "4 templates",
      },
      disable_frontmatter = true,
      note_id_func = function(title)
        return title
      end,
      notes_subdir = "0 Inbox",
      new_notes_location = "notes_subdir",
    },
    cmd = {
      "ObsidianQuickSwitch",
    },
    keys = {
      { "<leader>o", "", desc = "+obsidian" },
      { "<leader>og", "<cmd>ObsidianSearch<CR>", desc = "Grep" },
      { "<leader>fo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find File" },
      { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian" },
      { "<leader>of", "<cmd>ObsidianFollowLink<CR>", desc = "Follow Link" },
      { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Template" },
      { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Obsidian" },
    },
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

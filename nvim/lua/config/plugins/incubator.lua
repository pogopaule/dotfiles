return {
  {
    'https://github.com/tomasky/bookmarks.nvim',
    event = 'VeryLazy',
    config = function()
      require('bookmarks').setup {
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
        keywords = {
          ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
          ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
          ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
        },
        on_attach = function(bufnr)
          local bm = require "bookmarks"
          local map = vim.keymap.set
          map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
          map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
          map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
          map("n", "mx", bm.bookmark_clear_all) -- removes all bookmarks
        end
      }
    end
  },
  {
    'https://github.com/stevearc/aerial.nvim',
    opts = {},
    event = 'BufRead',
    keys = {
      { '<leader>to', '<CMD>AerialToggle<CR>',    desc = 'Aerial' },
      { '<leader>tO', '<CMD>AerialNavToggle<CR>', desc = 'AerialNav' },
    },
    cmd = { 'AerialToggle', 'AerialPrev', 'AerialNext' },
    config = {
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    }
  },
  {
    "https://github.com/hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
  },
  {
    'https://github.com/andythigpen/nvim-coverage',
    event = 'VeryLazy',
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
      { '<leader>Tcc', '<CMD>Coverage<CR>',        desc = 'Coverage' },
      { '<leader>Tct', '<CMD>CoverageToggle<CR>',  desc = 'Toggle' },
      { '<leader>Tcs', '<CMD>CoverageSummary<CR>', desc = 'Summary' },
    },
  },
  {
    "https://github.com/danielfalk/smart-open.nvim",
    branch = "0.2.x",
    event = 'VeryLazy',
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "https://github.com/kkharji/sqlite.lua",
    },
    keys = {
      { '<leader>fx', '<CMD>Telescope smart_open<CR>', desc = 'Smart Open' },
    },
  },
  {
    'https://github.com/stevearc/oil.nvim',
    dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
    config = true,
    cmd = { 'Oil' },
  },
  {
    "https://github.com/RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require('illuminate').configure({
        filetypes_denylist = {
          'Outline',
          'aerial-nav',
          'aerial',
        },
      })
    end,
  },
  {
    'https://github.com/ThePrimeagen/harpoon',
    event = 'VeryLazy',
    keys = {
      { '<leader>H',  '<CMD>lua require("harpoon.mark").add_file()<CR>', desc = 'Add File to Harpoon' },
      { '<leader>fH', '<CMD>Telescope harpoon marks<CR>',                desc = 'Find Harpoon File' },
      { '<leader>1',  '<CMD>:lua require("harpoon.ui").nav_file(1)<CR>', desc = 'Go to Harpoon File 1' },
      { '<leader>2',  '<CMD>:lua require("harpoon.ui").nav_file(2)<CR>', desc = 'Go to Harpoon File 2' },
      { '<leader>3',  '<CMD>:lua require("harpoon.ui").nav_file(3)<CR>', desc = 'Go to Harpoon File 3' },
    },
    config = true,
  },
  {
    'https://github.com/AckslD/nvim-neoclip.lua',
    event = 'VeryLazy',
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
    end,
  },
  {
    'https://github.com/sindrets/diffview.nvim',
    lazy = false,
    conifg = true,
  },
}

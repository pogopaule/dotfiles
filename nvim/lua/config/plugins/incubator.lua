return {
  {
    "https://github.com/yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
    },
    dependencies = {
      "https://github.com/nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "https://github.com/stevearc/dressing.nvim",
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      -- {
      --   'MeanderingProgrammer/render-markdown.nvim',
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },
  {
    'https://github.com/tomasky/bookmarks.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>mm', '<CMD>lua require("bookmarks").bookmark_toggle()<CR>',           desc = 'Toggle Bookmark' },
      { '<leader>me', '<CMD>lua require("bookmarks").bookmark_ann()<CR>',              desc = 'Add Annotation' },
      { '<leader>mc', '<CMD>lua require("bookmarks").bookmark_clean()<CR>',            desc = 'Clean Bookmarks' },
      { '<leader>mn', '<CMD>lua require("bookmarks").bookmark_next()<CR>',             desc = 'Next Bookmark' },
      { '<leader>mp', '<CMD>lua require("bookmarks").bookmark_prev()<CR>',             desc = 'Previous Bookmark' },
      { '<leader>ml', '<CMD>lua require("telescope").extensions.bookmarks.list()<CR>', desc = 'List Bookmarks' },
      { '<leader>mx', '<CMD>lua require("bookmarks").bookmark_clear_all()<CR>',        desc = 'Clear All Bookmarks' },
    },
    config = function()
      require('bookmarks').setup {
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
        signs = {
          add = {
            text = "",
          },
          ann = {
            text = "",
          },
        },
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
      { '<leader>fO', '<CMD>Telescope aerial<CR>', desc = 'Outline' },
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
    'https://github.com/stevearc/oil.nvim',
    dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
    config = true,
    cmd = { 'Oil' },
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
    'https://github.com/sindrets/diffview.nvim',
    lazy = false,
    conifg = true,
  },
}

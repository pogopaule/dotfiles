return {
  {
    'https://github.com/folke/flash.nvim',
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T" }, -- this removes ',' from the list, which I use as the leader key
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
    },
  },

  {
    'https://github.com/nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      { '<leader>fh',  '<CMD>Telescope help_tags<CR>',                     desc = 'Help' },
      { '<leader>fk',  '<CMD>Telescope keymaps<CR>',                       desc = 'Keymaps' },
      { '<leader>fS',  '<CMD>Telescope spell_suggest<CR>',                 desc = 'Spelling' },
      { '<leader>fg',  '<CMD>Telescope live_grep<CR>',                     desc = 'Grep' },
      { '<leader>fG',  '<CMD>Telescope grep_string<CR>',                   desc = 'Find Word Under Cursor' },
      { '<leader>f:',  '<CMD>Telescope command_history<CR>',               desc = 'Command History' },
      { '<leader>f/',  '<CMD>Telescope current_buffer_fuzzy_find<CR>',     desc = 'Fuzzy Find In Current Buffer' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown {} }
        },
        defaults = {
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
      telescope.load_extension('ui-select')
    end
  }
}

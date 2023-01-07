return {
  -- Jump in text
  {
    'https://github.com/ggandor/leap.nvim',
    keys = { 's', 'S', 'gs', { 'x', mode = 'v' }, { 'X', mode = 'v' } },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  -- Find, Filter, Preview, Pick
  { 'https://github.com/nvim-telescope/telescope.nvim' },

  -- use telescope to select options
  {
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    event = 'VeryLazy',
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown {} }
        },
        defaults = {
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          mappings = {
            i = {
              ["<C-i>"] = function()
                require("telescope.builtin").find_files({no_ignore = true})
              end,
              ["<C-h>"] = function()
                require("telescope.builtin").find_files({hidden = true})
              end,
            },
          },
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
      require('telescope').load_extension('ui-select')
    end
  },
}

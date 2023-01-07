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

  -- Seamless jumping between vim and tmux
  {
    'https://github.com/alexghergh/nvim-tmux-navigation',
    keys = {
      { '<C-h>', "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<CR>", desc = 'Tmux Left',
        mode = { 'n', 'v', 'i' } },
      { '<C-j>', "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<CR>", desc = 'Tmux Down',
        mode = { 'n', 'v', 'i' } },
      { '<C-k>', "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<CR>", desc = 'Tmux Up',
        mode = { 'n', 'v', 'i' } },
      { '<C-l>', "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<CR>", desc = 'Tmux Right',
        mode = { 'n', 'v', 'i' } },
    },
    config = {},
  },

}

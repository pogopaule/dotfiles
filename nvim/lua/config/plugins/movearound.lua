return {
  -- Jump in text
  {
    'https://github.com/ggandor/leap.nvim',
    keys = { 's', 'S', 'gs', { 'x', mode = 'v' }, { 'X', mode = 'v' } },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  {
    'https://github.com/ggandor/flit.nvim',
    keys = {
      'f',
      'F',
      't',
      'T',
      { 'f', mode = 'x' },
      { 'f', mode = 'x' },
      { 't', mode = 'x' },
      { 'T', mode = 'x' },
    },
    config = true,
  },

  -- Find, Filter, Preview, Pick
  { 'https://github.com/nvim-telescope/telescope.nvim' },

  -- use telescope to select options
  {
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    cmd = 'Telescope';
    keys = {
      { '<leader>ff', '<CMD>Telescope find_files<CR>', desc = 'Files' },
      { '<leader>fh', '<CMD>Telescope help_tags<CR>', desc = 'Help' },
      { '<leader>fo', '<CMD>Telescope oldfiles<CR>', desc = 'Old Files' },
      { '<leader>fk', '<CMD>Telescope keymaps<CR>', desc = 'Keymaps' },
      { '<leader>fs', '<CMD>Telescope spell_suggest<CR>', desc = 'Spelling' },
      { '<leader>fg', '<CMD>Telescope live_grep<CR>', desc = 'Grep' },
      { '<leader>fd', '<CMD>Telescope live_grep cwd=~/dotfiles/nvim/<CR>', desc = 'Grep Nvim Config' },
      { '<leader>fG', '<CMD>Telescope grep_string<CR>', desc = 'Find Word Under Cursor' },
      { '<leader>fc', '<CMD>Telescope git_commits<CR>', desc = 'Git Commits' },
      { '<leader>fb', '<CMD>Telescope git_bcommits<CR>', desc = 'Git Commits For Buffer' },
      { '<leader>f:', '<CMD>Telescope command_history<CR>', desc = 'Command History' },
      { '<leader>f/', '<CMD>Telescope current_buffer_fuzzy_find<CR>', desc = 'Fuzzy Find In Current Buffer' },
    },
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
                require("telescope.builtin").find_files({ no_ignore = true })
              end,
              ["<C-h>"] = function()
                require("telescope.builtin").find_files({ hidden = true })
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
    config = function()
      require('nvim-tmux-navigation').setup({})
    end
  },

}

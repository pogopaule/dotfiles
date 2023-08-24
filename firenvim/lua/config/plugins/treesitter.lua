return {
  {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- Text objects like functions and variables
      { 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'markdown',
          'markdown_inline',
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
        matchup = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
          },
        },
      }
    end,
  },

  -- split or join blocks powered by treesitter
  {
    'https://github.com/Wansmer/treesj',
    keys = {
      { '<leader>j', '<CMD>TSJToggle<CR>', desc = 'TSJoin Toggle' },
    },
    config = {
      use_default_keymaps = false
    },
  },
}

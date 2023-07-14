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
          'bash', 'clojure', 'cmake', 'css', 'dockerfile', 'fennel', 'go', 'graphql', 'haskell', 'html', 'http',
          'java', 'javascript', 'jsdoc', 'json', 'json5', 'kotlin', 'lua', 'make', 'markdown', 'markdown_inline', 'nix',
          'python', 'regex', 'ruby', 'rust', 'scss', 'svelte', 'todotxt', 'toml', 'tsx', 'typescript', 'vim', 'vue',
          'yaml',
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

            -- TODO: check if these are useful
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ap'] = '@parameter.outer',
              ['ip'] = '@parameter.inner',
              ['ac'] = '@call.outer',
              ['ic'] = '@call.inner',
            },
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

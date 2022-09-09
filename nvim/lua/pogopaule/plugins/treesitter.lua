require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash', 'clojure', 'cmake', 'css', 'dockerfile', 'fennel', 'gitignore', 'go', 'graphql', 'haskell', 'html', 'http',
    'java', 'javascript', 'jsdoc', 'json', 'json5', 'kotlin', 'lua', 'make', 'markdown', 'markdown_inline', 'nix', 'python',
    'regex', 'ruby', 'rust', 'scss', 'sql', 'svelte', 'todotxt', 'toml', 'tsx', 'typescript', 'vim', 'vue', 'yaml',
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<A-s>',
      node_incremental = '<A-d>',
      -- scope_incremental = 'grc',
      node_decremental = '<A-e>',
    },
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
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['ap'] = '@parameter.outer',
        ['ip'] = '@parameter.inner',
        ['ac'] = '@call.outer',
        ['ic'] = '@call.inner',
        ['ai'] = '@item',
      },
    },
  },
}

-- FIXME: folding does not always work, figure out why
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

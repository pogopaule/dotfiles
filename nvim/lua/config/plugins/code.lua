return {
  -- Nvim Treesitter configurations and abstraction layer
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
    end,
  },

  -- extends %
  {
    'https://github.com/andymass/vim-matchup',
    event = 'BufReadPost',
  },

  -- Comments
  {
    'https://github.com/numToStr/Comment.nvim',
    keys = { 'gc', { 'gc', mode = 'v' } },
    config = true,
  },

  -- Colorize hex colors
  {
    'https://github.com/NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = true,
  },

  -- Highlight, list and search todo comments
  {
    'https://github.com/folke/todo-comments.nvim',
    event = 'BufReadPost',
    config = true,
  },

  -- Markdown
  {
    'https://github.com/preservim/vim-markdown',
    ft = 'markdown',
  },

  -- Refactoring
  {
    'https://github.com/ThePrimeagen/refactoring.nvim',
  },

  -- Preview markdown, requires live-preview and pandoc to be installed
  {
    'https://github.com/davidgranstrom/nvim-markdown-preview',
    ft = 'markdown',
  },

  -- split or join blocks powered by treesitter
  {
    'https://github.com/Wansmer/treesj',
    cmd = { 'TSJToggle', 'TSJJoin', 'TSJSplit' },
    config = { use_default_keymaps = false },
  },

  -- easily surround with brackets
  {
    'https://github.com/kylechui/nvim-surround',
    keys = { 'ys', 'cs', 'ds' },
    config = true,
  },

  -- Insert matching quote, brackets, etc.
  {
    'https://github.com/windwp/nvim-autopairs',
    event = 'BufReadPre',
    config = function()
      require('nvim-autopairs').setup({ fast_wrap = {} })
      -- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },

  -- Send line to tmux
  {
    'https://github.com/jpalardy/vim-slime',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[
          let g:slime_target = "tmux"
          let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
          let g:slime_dont_ask_default = 1
        ]])
    end
  },
}

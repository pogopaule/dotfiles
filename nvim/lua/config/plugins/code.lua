return {
  -- extends %
  {
    'https://github.com/andymass/vim-matchup',
    event = { 'BufReadPost', 'BufNewFile' },
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
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- Highlight, list and search todo comments
  {
    'https://github.com/folke/todo-comments.nvim',
    cmd = 'TodoTelescope',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>ft', '<CMD>TodoTelescope<CR>', 'Todos' },
    },
    config = true,
  },

  -- Refactoring
  {
    'https://github.com/ThePrimeagen/refactoring.nvim',
    keys = {
      {
        '<leader>ri',
        "<CMD>lua require('refactoring').refactor('Inline Variable')<CR>",
        desc = 'Inline Variable',
      },
    },
  },

  -- easily surround with brackets
  {
    'https://github.com/kylechui/nvim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
    config = {
      keymaps = {
        normal = 'ygs',
        change = 'cgs',
        change_line = 'cgS',
        delete = 'dgs',
      },
    },
  },

  -- Insert matching quote, brackets, etc.
  {
    'https://github.com/windwp/nvim-autopairs',
    event = { 'BufReadPre', 'BufNewFile' },
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
    init = function()
      vim.cmd [[let g:slime_no_mappings = 1]]
    end,
    config = function()
      local map = vim.keymap.set
      map('x', '<bar>', '<Plug>SlimeRegionSend', {})
      map('n', '<bar>', '<Plug>SlimeParagraphSend', {})

      vim.cmd([[
          let g:slime_target = "tmux"
          let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
          let g:slime_dont_ask_default = 1
        ]])
    end
  },

  -- Copilot
  {
    'https://github.com/zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = {
      suggestion = {
        auto_trigger = true,
      }
    },
  },

  -- Emmet
  {
    'https://github.com/mattn/emmet-vim',
    ft = {
      'html',
      'css',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'vue',
      'svelte',
      'markdown',
      'handlebars',
    },
  }
}

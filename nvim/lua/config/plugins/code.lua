return {
  -- snake_case to camelCase and more
  {
    'https://github.com/johmsalas/text-case.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('textcase').setup {}
      require('telescope').load_extension('textcase')
      vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
      vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end
  },

  {
    'https://github.com/simrat39/rust-tools.nvim',
    config = true,
    ft = 'rust',
  },

  -- extends %
  {
    'https://github.com/andymass/vim-matchup',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Comments
  {
    'https://github.com/numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
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
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "<leader>ss",
        normal_line = "<leader>sS",
        normal_cur = "<leader>sl",
        normal_cur_line = "<leader>sL",
        visual = "<leader>s",
        visual_line = "<leader>S",
        delete = "<leader>sd",
        change = "<leader>sc",
        change_line = "<leader>sC",
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
    config = function()
      vim.g.user_emmet_leader_key = '<C-Z>' -- because C-Y is used by cmp
    end,
  }
}

return {
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
    cmd = 'TodoTelescope',
    event = 'BufReadPost',
    config = true,
  },

  -- Refactoring
  {
    'https://github.com/ThePrimeagen/refactoring.nvim',
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
    init = function()
      vim.cmd [[let g:slime_no_mappings = 1]]
    end,
    config = function()
      local map = vim.keymap.set
      map('x', '<C-s>', '<Plug>SlimeRegionSend', {})
      map('n', '<C-s>', '<Plug>SlimeParagraphSend', {})

      vim.cmd([[
          let g:slime_target = "tmux"
          let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
          let g:slime_dont_ask_default = 1
        ]])
    end
  },
}
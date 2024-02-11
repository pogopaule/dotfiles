return {
  {
    'https://github.com/rest-nvim/rest.nvim',
    config = true,
  },
  {
    'https://github.com/ThePrimeagen/harpoon',
    event = 'VeryLazy',
    keys = {
      { '<leader>H',  '<CMD>lua require("harpoon.mark").add_file()<CR>', desc = 'Harpoon File' },
      { '<leader>fH', '<CMD>Telescope harpoon marks<CR>',                desc = 'Find Harpoon File' },
      { '<leader>1',  '<CMD>:lua require("harpoon.ui").nav_file(1)<CR>', desc = 'Harpoon File 1' },
      { '<leader>2',  '<CMD>:lua require("harpoon.ui").nav_file(2)<CR>', desc = 'Harpoon File 2' },
      { '<leader>3',  '<CMD>:lua require("harpoon.ui").nav_file(3)<CR>', desc = 'Harpoon File 3' },
    },
    config = true,
  },
  {
    'https://github.com/AckslD/nvim-neoclip.lua',
    event = 'VeryLazy',
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
    end,
  },
  {
    'https://github.com/sindrets/diffview.nvim',
    lazy = false,
    conifg = true,
  },
  -- ChatGPT
  {
    'https://github.com/jackMort/ChatGPT.nvim',
    config = {
      welcome_message = '',
      keymaps = {
        submit = "<C-s>",
      },
    },
    keys = {
      { '<leader>c', '<CMD>ChatGPT<CR>', desc = 'ChatGPT' },
    },
    dependencies = { 'https://github.com/MunifTanjim/nui.nvim' }
  },

  -- ChatGPT
  {
    'https://github.com/dpayne/CodeGPT.nvim',
    lazy = false,
    dependencies = {
      'https://github.com/MunifTanjim/nui.nvim',
      'https://github.com/nvim-lua/plenary.nvim',
    }
  },
}

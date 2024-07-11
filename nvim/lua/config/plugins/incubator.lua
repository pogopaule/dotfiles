return {
  {
    "https://github.com/danielfalk/smart-open.nvim",
    branch = "0.2.x",
    event = 'VeryLazy',
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "https://github.com/kkharji/sqlite.lua",
    },
    keys = {
      { '<leader>fx', '<CMD>Telescope smart_open<CR>', desc = 'Smart Open' },
    },
  },
  {
    'https://github.com/stevearc/oil.nvim',
    dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
    config = true,
    cmd = { 'Oil' },
  },
  {
    "https://github.com/RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require('illuminate').configure()
    end,
  },
  {
    'https://github.com/ThePrimeagen/harpoon',
    event = 'VeryLazy',
    keys = {
      { '<leader>H',  '<CMD>lua require("harpoon.mark").add_file()<CR>', desc = 'Add File to Harpoon' },
      { '<leader>fH', '<CMD>Telescope harpoon marks<CR>',                desc = 'Find Harpoon File' },
      { '<leader>1',  '<CMD>:lua require("harpoon.ui").nav_file(1)<CR>', desc = 'Go to Harpoon File 1' },
      { '<leader>2',  '<CMD>:lua require("harpoon.ui").nav_file(2)<CR>', desc = 'Go to Harpoon File 2' },
      { '<leader>3',  '<CMD>:lua require("harpoon.ui").nav_file(3)<CR>', desc = 'Go to Harpoon File 3' },
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
}

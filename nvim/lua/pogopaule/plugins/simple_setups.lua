require('gitsigns').setup()          -- lewis6991/gitsigns.nvim
require('Comment').setup()           -- numToStr/Comment.nvim
require('todo-comments').setup()     -- folke/todo-comments.nvim
require('lualine').setup()           -- nvim-lualine/lualine.nvim
require('colorizer').setup()         -- nvim-colorizer.lua
require('lsp_signature').setup()     -- ray-x/lsp_signature.nvim
require('lspsaga').setup()           -- tami5/lspsaga.nvim
require('nvim-web-devicons').setup() -- kyazdani42/nvim-web-devicons

require('nvim-tree').setup({
  filters = {
    dotfiles = true,
  }
})
vim.g.nvim_tree_special_files = {}

-- mhinz/vim-startify
vim.cmd([[
let g:startify_custom_header =[]
]])

-- max397574/better-escape.nvim
require("better_escape").setup {
    mapping = {"jk"},
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
}

-- akinsho/bufferline.nvim
require('bufferline').setup({
  options = {
    offsets = {{
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left"
    }}
  }
})

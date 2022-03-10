require('gitsigns').setup()               -- lewis6991/gitsigns.nvim
require('Comment').setup()                -- numToStr/Comment.nvim
require('todo-comments').setup()          -- folke/todo-comments.nvim
require('colorizer').setup()              -- nvim-colorizer.lua
require('lsp_signature').setup()          -- ray-x/lsp_signature.nvim
require('nvim-web-devicons').setup()      -- kyazdani42/nvim-web-devicons
require('refactoring').setup()            -- ThePrimeagen/refactoring.nvim
require('close_buffers').setup()          -- kazhala/close-buffers.nvim
require('fidget').setup()                 -- j-hui/fidget.nvim


-- windwp/nvim-autopairs
require('nvim-autopairs').setup({
  fast_wrap = {
    map = '<A-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0,
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"


-- nvim-tree
require('nvim-tree').setup({
  filters = {
    dotfiles = true,
  },
  view = {
    mappings = {
      list = {
        { key = {'cd'}, action = 'cd' },
      }
    },
    width = 50,
  }
})
vim.g.nvim_tree_special_files = {}


-- EdenEast/nightfox.nvim
local nightfox = require('nightfox')
nightfox.setup({
  fox = 'dayfox',
  styles = {
    comments = "italic",
    keywords = "bold",
  },
})
nightfox.load()

-- nvim-lualine/lualine.nvim
require('lualine').setup({
  options = {
    theme = "nightfox"
  }
})

-- -- rmagatti/auto-session
-- require('auto-session').setup {
--   log_level = 'info',
-- }

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

-- folke/trouble.nvim
require("trouble").setup {}

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

-- nvim-neorg/neorg
require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.integrations.nvim-cmp"] = {},
    ["core.norg.concealer"] = {},
  }
}

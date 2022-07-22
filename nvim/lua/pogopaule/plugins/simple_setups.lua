require('gitsigns').setup()               -- lewis6991/gitsigns.nvim
require('Comment').setup()                -- numToStr/Comment.nvim
require('todo-comments').setup()          -- folke/todo-comments.nvim
require('colorizer').setup()              -- nvim-colorizer.lua
require('lsp_signature').setup()          -- ray-x/lsp_signature.nvim
require('nvim-web-devicons').setup()      -- kyazdani42/nvim-web-devicons
require('refactoring').setup()            -- ThePrimeagen/refactoring.nvim
require('close_buffers').setup()          -- kazhala/close-buffers.nvim
require('fidget').setup()                 -- j-hui/fidget.nvim
require('leap').set_default_keymaps()     -- ggandor/leap.nvim
require('nvim-surround').setup()          -- kylechui/nvim-surround
require("which-key").setup()              -- folke/which-key.nvim
require('octo').setup()                   -- pwntester/octo.nvim


-- zakharykaplan/nvim-retrail
require("retrail").setup {
  -- Highlight group to use for trailing whitespace.
  -- list all hlgroups with `:so $VIMRUNTIME/syntax/hitest.vim`
  hlgroup = "Substitute",
  -- Enabled filetypes.
  filetype = {
    -- Strictly enable only on `include`ed filetypes. When false, only disabled
    -- on an `exclude`ed filetype.
    strict = false,
    -- Included filetype list.
    include = {},
    -- Excluded filetype list. Overrides `include` list.
    exclude = {
      "",
      "alpha",
      "help"
    },
  },
  -- Trim on write behaviour.
  trim = {
    -- Final blank (i.e. whitespace only) lines.
    blanklines = true,
  }
}

-- nvim-telescope/telescope-ui-select.nvim
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

-- https://github.com/nvim-telescope/telescope-dap.nvim#setup
require('telescope').load_extension('dap')

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
-- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- nvim-tree
require('nvim-tree').setup({
  filters = {
    dotfiles = true,
  },
  git = {
    ignore = false,
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
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
    },
  }
})
vim.cmd("colorscheme dayfox")

-- nvim-lualine/lualine.nvim
require('lualine').setup()

-- goolord/alpha-nvim
require'alpha'.setup(require'alpha.themes.startify'.config)

-- karb94/neoscroll.nvim
require('neoscroll').setup()

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

-- jpalardy/vim-slim
vim.cmd([[
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
]])

-- nvim-neotest/neotest
require('neotest').setup({
  adapters = {
    require('neotest-python')({
      -- dap = { justMyCode = false },
    }),
  },
})

-- haringsrob/nvim_context_vt
require('nvim_context_vt').setup()

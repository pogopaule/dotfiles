-- https://github.com/rcarriga/nvim-notify
vim.notify = require("notify")

require('gitsigns').setup()            -- https://github.com/lewis6991/gitsigns.nvim
require('Comment').setup()             -- https://github.com/numToStr/Comment.nvim
require('todo-comments').setup()       -- https://github.com/folke/todo-comments.nvim
require('colorizer').setup()           -- https://github.com/nvim-colorizer.lua
require('nvim-web-devicons').setup()   -- https://github.com/kyazdani42/nvim-web-devicons
require('refactoring').setup()         -- https://github.com/ThePrimeagen/refactoring.nvim
require('close_buffers').setup()       -- https://github.com/kazhala/close-buffers.nvim
require('fidget').setup()              -- https://github.com/j-hui/fidget.nvim
require('leap').set_default_keymaps()  -- https://github.com/ggandor/leap.nvim
require('which-key').setup()           -- https://github.com/folke/which-key.nvim
require('octo').setup()                -- https://github.com/pwntester/octo.nvim
require('trouble').setup()             -- https://github.com/folke/trouble.nvim
require('gitlinker').setup()           -- https://github.com/ruifm/gitlinker.nvim
require('debugprint').setup()          -- https://github.com/andrewferrier/debugprint.nvim

-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup({
  options = {
    disabled_filetypes = {
      statusline = { 'NvimTree'},
    },
  },
})

-- https://github.com/goolord/alpha-nvim
local alpha_config = require('alpha.themes.startify').config
require('alpha').setup(alpha_config)

-- https://github.com/zakharykaplan/nvim-retrail
require('retrail').setup {
  -- Highlight group to use for trailing whitespace.
  -- list all hlgroups with `:so $VIMRUNTIME/syntax/hitest.vim`
  hlgroup = 'Substitute',
  -- Enabled filetypes.
  filetype = {
    -- Strictly enable only on `include`ed filetypes. When false, only disabled
    -- on an `exclude`ed filetype.
    strict = false,
  },
  -- Trim on write behaviour.
  trim = {
    -- Final blank (i.e. whitespace only) lines.
    blanklines = true,
  }
}


-- https://github.com/nvim-telescope/telescope-ui-select.nvim
require('telescope').setup {
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        -- even more opts
      }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
require('telescope').load_extension('ui-select')

-- https://github.com/nvim-telescope/telescope-dap.nvim#setup
require('telescope').load_extension('dap')


-- https://github.com/windwp/nvim-autopairs
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


-- https://github.com/EdenEast/nightfox.nvim
local nightfox = require('nightfox')
nightfox.setup({
  options = {
    styles = {
      comments = 'italic',
      keywords = 'bold',
    },
  }
})
if os.getenv("THEME") == "light" then
  vim.cmd('colorscheme dayfox')
else
  vim.cmd('colorscheme nordfox')
end


-- https://github.com/akinsho/bufferline.nvim
require('bufferline').setup({
  options = {
    offsets = {{
      filetype = 'NvimTree',
      text = 'File Explorer',
      highlight = 'Directory',
      text_align = 'left'
    }}
  }
})


-- https://github.com/jpalardy/vim-slim
vim.cmd([[
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
]])


-- https://github.com/nvim-neotest/neotest
require('neotest').setup({
  adapters = {
    require('neotest-python')({
      -- dap = { justMyCode = false },
    }),
  },
})

-- https://github.com/kylechui/nvim-surround
require('nvim-surround').setup()

-- https://github.com/lukas-reineke/indent-blankline.nvim
require("indent_blankline").setup {
    show_current_context = true,
    -- show_current_context_start = true,
}

-- https://github.com/karb94/neoscroll.nvim
require('neoscroll').setup({
  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
})

-- https://github.com/tyru/open-browser.vim
vim.cmd([[
" disable netrw's gx mapping.
let g:netrw_nogx = 1

" xdg-open which is the default does not work
let g:openbrowser_browser_commands = [
\ {"name": "x-www-browser",
\  "args": ["{browser}", "{uri}"]},
\]

let g:openbrowser_default_search = 'duckduckgo'

]])

-- https://github.com/monaqa/dial.nvim
local augend = require("dial.augend")
require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    augend.constant.alias.bool,
  },
}

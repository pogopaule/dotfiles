-- https://github.com/rcarriga/nvim-notify
vim.notify = require("notify")

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

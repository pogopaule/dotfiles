-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(plugins, opts)

pcall(require('impatient'))

require 'pogopaule.plugins'
require 'pogopaule.options'
require 'pogopaule.keymaps'

require 'pogopaule.plugins.cmp'
require 'pogopaule.plugins.treesitter'
require 'pogopaule.lsp'
require 'pogopaule.plugins.gh'
require 'pogopaule.plugins.dap'
require 'pogopaule.plugins.luasnip'
require 'pogopaule.plugins.telekasten'

-- for awesome-sustainability-jobs
vim.api.nvim_create_user_command('PasteGeo', 'normal "+p0f:lldf@f,f,DF,xDj0$p', {})

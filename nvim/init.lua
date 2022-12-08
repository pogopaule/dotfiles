local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd('packadd packer.nvim')
end


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

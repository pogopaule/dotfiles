require('impatient')

require 'pogopaule.options'
require 'pogopaule.keymaps'
require 'pogopaule.plugins'

require 'pogopaule.plugins.simple_setups'
require 'pogopaule.plugins.cmp'
require 'pogopaule.plugins.treesitter'
require 'pogopaule.lsp'
require 'pogopaule.plugins.telekasten'
require 'pogopaule.plugins.gh'
require 'pogopaule.plugins.dap'
require 'pogopaule.plugins.luasnip'

-- for awesome-sustainability-jobs
vim.api.nvim_create_user_command('PasteGeo', 'normal "+p0f:lldf@f,f,DF,xDj0$p', {})

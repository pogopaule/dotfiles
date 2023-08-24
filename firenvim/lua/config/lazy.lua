-- has to be defined here so keys activation work properly
-- see https://github.com/folke/lazy.nvim#-installation
vim.g.mapleader = ','

-- for https://github.com/tyru/open-browser.vim
vim.cmd([[
  " disable netrw's gx mapping.
  let g:netrw_nogx = 1
  let g:openbrowser_default_search = 'duckduckgo'
]])


require('lazy').setup('config.plugins', {
  defaults = {
    lazy = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    }
  },
})

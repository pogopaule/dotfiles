-- TODO: checkout plugins
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/jose-elias-alvarez/typescript.nvim additional lsp features for typescript, mainly imports related
-- as a replacement for null-ls: https://github.com/nvimtools/none-ls.nvim
-- lazyvim uses https://github.com/mfussenegger/nvim-lint and https://github.com/stevearc/conform.nvim instead of none-ls
-- https://github.com/chrisgrieser/nvim-scissors


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

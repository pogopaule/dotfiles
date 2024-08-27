-- TODO: checkout plugins
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/jose-elias-alvarez/typescript.nvim additional lsp features for typescript, mainly imports related
-- https://github.com/ms-jpq/chadtree alternative to nvim-tree?
-- https://github.com/danymat/neogen generate annotations and documentation
-- https://github.com/ThePrimeagen/harpoon naviage favorite locations
-- https://github.com/mizlan/iswap.nvim swapping powered by treesitter
-- https://github.com/Vonr/align.nvim replace Tabularize?
-- https://github.com/jakewvincent/mkdnflow.nvim
-- as a replacement for null-ls: https://github.com/nvimtools/none-ls.nvim
-- lazyvim uses https://github.com/mfussenegger/nvim-lint and https://github.com/stevearc/conform.nvim instead of none-ls
-- https://github.com/nvim-telescope/telescope-live-grep-args.nvim


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

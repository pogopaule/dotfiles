require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-s>",
      node_incremental = "<A-e>",
      -- scope_incremental = "grc",
      node_decremental = "<A-d>",
    },
  },
  indent = {
    enable = true
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      -- TODO: check if these are useful
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
      },
    },
  },
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

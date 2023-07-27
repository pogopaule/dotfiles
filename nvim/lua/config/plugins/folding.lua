return {
  {
    'https://github.com/kevinhwang91/nvim-ufo',
    lazy = false,
    dependencies = 'https://github.com/kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      -- Option 3: treesitter as a main provider instead
      -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      require('ufo').setup({
        provider_selector = function()
          return { 'indent' }
        end
      })
    end
  },
  {
    'https://github.com/luukvbaal/statuscol.nvim',
    lazy = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { "%s" } },
          { text = { builtin.lnumfunc }, },
          {
            text = { " ", builtin.foldfunc, "  " },
            condition = { builtin.not_empty, true, builtin.not_empty }
          },
        },
      })
    end,
  }
}

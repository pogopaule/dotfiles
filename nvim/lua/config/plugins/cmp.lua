return {
  {
    'https://github.com/hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    dependencies = {
      { 'https://github.com/hrsh7th/cmp-nvim-lsp' },
      { 'https://github.com/hrsh7th/cmp-buffer' },
      { 'https://github.com/hrsh7th/cmp-path' },
      { 'https://github.com/hrsh7th/cmp-cmdline' },
      { 'https://github.com/saadparwaiz1/cmp_luasnip' },
      -- vscode-like pictograms for neovim lsp completion items
      { 'https://github.com/onsails/lspkind-nvim' },
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local luasnip = require('luasnip')


      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
          })
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = { -- the order below defines the order in the completion popup
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'buffer', option = { keyword_pattern = [[\k\+]] } },
          -- { name = 'tmux' }, disable, causes too much problems
          { name = 'path' },
        },
        window = {
          documentation = cmp.config.window.bordered(),
        }
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        },
        mapping = cmp.mapping.preset.cmdline({}),
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({}),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              -- fixes hanging on typing, e.g. :read !http <url>
              -- see https://github.com/hrsh7th/cmp-cmdline/issues/24
              ignore_cmds = { 'read' }
            }
          }
        }),
      })
    end,
  },
}

local cmp = require 'cmp'
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
  mapping = cmp.mapping.preset.insert(),
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
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  mapping = cmp.mapping.preset.cmdline({}),
})

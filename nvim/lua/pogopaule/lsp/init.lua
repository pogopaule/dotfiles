local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require('pogopaule.lsp.mason')
require('pogopaule.lsp.null-ls')
require('lspsaga').init_lsp_saga() -- https://github.com/glepnir/lspsaga.nvim


local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

-- disable virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = false,
})

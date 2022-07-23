local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require('pogopaule.lsp.lsp-installer')
require('pogopaule.lsp.null-ls')
require('lspsaga').init_lsp_saga() -- https://github.com/glepnir/lspsaga.nvim

-- disable virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = false,
})

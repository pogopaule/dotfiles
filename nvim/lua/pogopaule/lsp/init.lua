local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("pogopaule.lsp.lsp-installer")
require("pogopaule.lsp.null-ls")

-- tami5/lspsaga.nvim
require('lspsaga').setup()

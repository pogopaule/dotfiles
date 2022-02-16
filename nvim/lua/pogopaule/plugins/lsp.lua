
-- neovim/nvim-lspconfig
local servers = { 'pyright', 'tsserver', 'jsonls', 'sumneko_lua' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end

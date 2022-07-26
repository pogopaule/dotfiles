require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'sumneko_lua', 'jsonls', 'pylsp', 'tsserver', 'yamlls' },
}
local lspconfig = require('lspconfig')

local function on_attach(client, buffer)
  -- TODO: Not sure why this was added
  -- if client.name == 'tsserver' then
  --   client.resolved_capabilities.document_formatting = false
  --   client.resolved_capabilities.document_range_formatting = false
  -- end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_create_autocmd('CursorHold', { callback = vim.lsp.buf.document_highlight, group = group, })
    vim.api.nvim_create_autocmd('CursorMoved', { callback = vim.lsp.buf.clear_references, group = group, })
  end

  require('lsp_signature').on_attach({
    hint_enable = false,
    floating_window_above_cur_line = false,
  }, buffer)
  -- setup buffer keymaps etc.
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

lspconfig.pylsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

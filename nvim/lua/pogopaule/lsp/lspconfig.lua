local lspconfig = require('lspconfig')

local function on_attach(client, buffer)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_create_autocmd('CursorHold', { buffer=buffer, callback = vim.lsp.buf.document_highlight, group = group, })
    vim.api.nvim_create_autocmd('CursorMoved', { buffer=buffer, callback = vim.lsp.buf.clear_references, group = group, })
  end

  require('lsp_signature').on_attach({
    hint_enable = false,
    floating_window_above_cur_line = false,
  }, buffer)
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

lspconfig.rnix.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

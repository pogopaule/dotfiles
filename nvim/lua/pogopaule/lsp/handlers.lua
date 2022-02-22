local M = {}

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

local function init_lsp_signature(buffer)
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, buffer)
end

M.on_attach = function(client, buffer)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
  lsp_highlight_document(client)
  init_lsp_signature(buffer)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M

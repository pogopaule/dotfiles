-- williamboman/nvim-lsp-installer
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished or if the server is already installed).
require("nvim-lsp-installer").on_server_ready(function(server)
    server:setup({})
end)

-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/handlers.lua#L47
-- highlight other references of word under cursor
local function lsp_highlight_document(client)
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


-- neovim/nvim-lspconfig
local servers = { 'pyright', 'tsserver', 'jsonls', 'sumneko_lua' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = function(client, buffer)
      lsp_highlight_document(client)
      require "lsp_signature".on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        }
      }, buffer)
      end,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
end

require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}

-- tami5/lspsaga.nvim
require('lspsaga').setup()

-- jose-elias-alvarez/null-ls.nvim
-- local null_ls = require("null-ls")
-- local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
-- null_ls.setup({
--   sources = {
--     formatting.prettier,
--     formatting.black.with({extra_args = {"--fast"}}),
--     diagnostics.eslint,
--     diagnostics.flake8,
--     null_ls.builtins.code_actions.refactoring
--   },
-- })

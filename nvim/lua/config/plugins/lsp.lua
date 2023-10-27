return {
  -- LSP support
  {
    'https://github.com/neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- LSP signature hint as you type
      { 'https://github.com/ray-x/lsp_signature.nvim' },
      -- JSON schema awareness, gives LSP completions for e.g. package.json
      { 'https://github.com/b0o/schemastore.nvim' },
    },
    config = function()
      local lspconfig = require('lspconfig')

      local function on_attach(client, buffer)
        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.documentHighlightProvider then
          local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
          vim.api.nvim_create_autocmd('CursorHold',
            { buffer = buffer, callback = vim.lsp.buf.document_highlight, group = group, })
          vim.api.nvim_create_autocmd('CursorMoved',
            { buffer = buffer, callback = vim.lsp.buf.clear_references, group = group, })
        end

        -- require('lsp_signature').on_attach({
        --   hint_enable = false,
        --   floating_window_above_cur_line = false,
        -- }, buffer)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.lua_ls.setup({
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

      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { -- see https://github.com/typescript-language-server/typescript-language-server/issues/411
          'typescript-language-server',
          '--stdio',
          '--tsserver-path',
          'tsserver'
        },
      })

      lspconfig.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.rnix.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- settings = {
        --   ["rust-analyzer"] = {
        --     checkOnSave = {
        --       command = "clippy",
        --     },
        --   },
        -- }
      })

      lspconfig.ruff_lsp.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          }
        }
      }


      -- nicer symbols
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
    end,
  },

  -- The neovim language-server-client UI
  {
    'https://github.com/nvimdev/lspsaga.nvim',
    event = { 'LspAttach' },
    keys = {
      { '<leader>a',  '<CMD>Lspsaga code_action<CR>',                 desc = 'LSP Code Action' },
      { '<leader>e',  '<CMD>Lspsaga show_line_diagnostics<CR>',       desc = 'LSP Line Diagnostics' },
      { 'K',          '<CMD>Lspsaga hover_doc<CR>',                   desc = 'Hover LSP documentation' },
      { '<leader>rr', '<CMD>Lspsaga rename<CR>',                      desc = 'Rename' },
      { 'gd',         '<CMD>Lspsaga goto_definition<CR>',             desc = 'Go to LSP definition' },
      { 'gD',         '<CMD>tab split | Lspsaga goto_definition<CR>', desc = 'Go to LSP definition in tab' },
      { '<leader>fr', '<CMD>Lspsaga finder<CR>',                      desc = 'Definition and References' },
    },
    config = {
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        virtual_text = false,
      },
      diagnostic = {
        on_insert = false,
      },
      finder = {
        keys = {
          toggle_or_open = '<CR>',
        },
      },
    }
  },

  -- Show LSP progress
  -- TODO: better lazy
  {
    'https://github.com/j-hui/fidget.nvim',
    event = 'VeryLazy',
    tag = 'legacy',
    config = true,
  },

  -- Nicer diagnostics
  {
    'https://github.com/folke/trouble.nvim',
    cmd = { 'Trouble' },
    keys = {
      { '<leader>xx', '<CMD>Trouble document_diagnostics<CR>',                  desc = 'Document' },
      { '<leader>xw', '<CMD>Trouble workspace_diagnostics<CR>',                 desc = 'Workspace' },
      { '<leader>xn', '<CMD>lua vim.diagnostic.goto_next({float = false})<CR>', desc = 'Goto Next' },
      { '<leader>xN', '<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>', desc = 'Goto Previous' },
    },
    config = true,
  },
}

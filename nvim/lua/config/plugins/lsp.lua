return {
  -- LSP support
  -- TODO: better lazy
  {
    'https://github.com/neovim/nvim-lspconfig',
    event = 'VeryLazy',
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

        require('lsp_signature').on_attach({
          hint_enable = false,
          floating_window_above_cur_line = false,
        }, buffer)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

      -- disable virtual text for diagnostics
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },

  -- The neovim language-server-client UI
  -- TODO: better lazy
  {
    'https://github.com/glepnir/lspsaga.nvim',
    event = 'BufRead',
    keys = {
      { '<leader>a', '<CMD>Lspsaga code_action<CR>', desc = 'LSP Code Action' },
      { '<leader>e', '<CMD>Lspsaga show_line_diagnostics<CR>', desc = 'LSP Line Diagnostics' },
      { 'K', '<CMD>Lspsaga hover_doc<CR>', desc = 'Hover LSP documentation' },
    },
    config = function()
      require('lspsaga').setup({
        code_action_lightbulb = {
          enable = true,
          sign = false,
          enable_in_insert = true,
          sign_priority = 20,
          virtual_text = true,
        },
      })
    end,
  },

  -- LSP bridge for linters and others
  -- TODO: better lazy
  {
    'https://github.com/jose-elias-alvarez/null-ls.nvim',
    event = 'VeryLazy',
    config = function()
      local null_ls = require('null-ls')

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      local formatting = null_ls.builtins.formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      local diagnostics = null_ls.builtins.diagnostics
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
      local code_actions = null_ls.builtins.code_actions

      local eslintConfig = {
        condition = function(utils)
          return utils.root_has_file({
            '.eslintrc.cjs',
            '.eslintrc.js',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
          })
        end
      }

      local prettierConfig = {
        condition = function(utils)
          return utils.root_has_file('.prettierrc')
        end
      }

      null_ls.setup({
        debug = false,
        sources = {
          -- formatting.black.with({ extra_args = { "--fast" } }),
          -- formatting.stylua,
          -- diagnostics.flake8
          formatting.eslint_d.with(eslintConfig),
          diagnostics.eslint_d.with(eslintConfig),
          code_actions.eslint_d.with(eslintConfig),

          formatting.prettier.with(prettierConfig),
        },
      })
    end,
  },


  -- Show LSP progress
  -- TODO: better lazy
  {
    'https://github.com/j-hui/fidget.nvim',
    event = 'VeryLazy',
    config = true,
  },

  -- Nicer diagnostics
  {
    'https://github.com/folke/trouble.nvim',
    cmd = { 'Trouble' },
    config = true,
  },
}

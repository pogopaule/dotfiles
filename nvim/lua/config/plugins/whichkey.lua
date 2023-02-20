return {
  -- shows what to type after a prefix
  {
    'https://github.com/folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      -- TODO: move mappings to plugin configs and only keep the +names
      wk.register({
        f = {
          name = '+Find',
          t = { '<CMD>TodoTelescope<CR>', 'Todos' },
        },
        r = {
          name = '+Refactor',
          i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
        },
        d = {
          name = '+Debug',
          c = { '<CMD>DapContinue<CR>', 'Continue' },
          o = { '<CMD>DapStepOver<CR>', 'Step Over' },
          i = { '<CMD>DapStepInto<CR>', 'Step Into' },
          u = { '<CMD>DapStepOut<CR>', 'Step Out' },
          b = { '<CMD>DapToggleBreakpoint<CR>', 'Toggle Breakpoint' },
          t = { '<CMD>lua require("dapui").toggle()<CR>', 'Toggle DAP UI' },
        },
        g = {
          name = '+Git',
          r = { '<CMD>Gitsigns reset_hunk<CR>', 'Reset Hunk' },
          bl = { '<CMD>Gitsigns blame_line<CR>', 'Blame Line' },
          bf = { '<CMD>G blame<CR>', 'Blame File' },
          p = { '<CMD>Gitsigns preview_hunk<CR>', 'Preview Hunk' },
          n = { '<CMD>Gitsigns next_hunk<CR>', 'Next Hunk' },
          N = { '<CMD>Gitsigns prev_hunk<CR>', 'Previous Hunk' },
          y = { '<CMD>lua require("gitlinker").get_buf_range_url("n")<CR>', 'Github Link' },
          g = { '<CMD>GBrowse<CR>', 'Open Buffer In Github' },
        },
        x = {
          name = '+Diagnostics',
          x = { '<CMD>Trouble document_diagnostics<CR>', 'Document' },
          w = { '<CMD>Trouble workspace_diagnostics<CR>', 'Workspace' },
          n = { '<CMD>lua vim.diagnostic.goto_next({float = false})<CR>', 'Goto Next' },
          p = { '<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>', 'Goto Previous' },
        },
        l = {
          name = '+Linenumbers',
          a = { '<CMD>set number!<CR>', 'Toggle Absolute Numbers' },
          r = { '<CMD>set relativenumber!<CR>', 'Toggle Relative Numbers' },
        },
        t = {
          name = '+Telekasten',
        },
        q = { '<CMD>quit<CR>', 'Quit', mode = { 'n', 'v' } },
        Q = { '<CMD>quitall<CR>', 'Quit All', mode = { 'n', 'v' } },
        w = { '<CMD>write<CR>', 'Write', mode = { 'n', 'v' }},
        h = { '<CMD>nohlsearch<CR>', 'Remove Highlight' },
        p = { '"+p', 'Paste From Clipboard', mode = { 'n', 'v' }},
        s = { ':%s///gc<left><left><left><left>', 'Substitute', silent = false },
      }, { prefix = '<leader>' })

      wk.register({
        r = {
          name = '+Refactor',
          i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
          f = { "<ESC><CMD>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
          v = { "<ESC><CMD>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
        },
        y = { '"+y', 'Yank To Clipboard' },
        s = { '"hy:%s/<C-r>h//gc<left><left><left>', 'Substitute Selection', silent = false },

      }, { prefix = '<leader>', mode = 'v' })
    end,
  },
}

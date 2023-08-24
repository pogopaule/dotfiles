return {
  -- shows what to type after a prefix
  {
    'https://github.com/folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()

      local lspVirtualText = true
      local function toggleLspVirtualText()
        lspVirtualText = not lspVirtualText
        vim.diagnostic.config({ virtual_text = lspVirtualText })
      end

      local function toggleSpellCheck()
        if vim.o.spell then
          vim.o.spell = false
          vim.notify('Spell check disabled')
        else
          vim.o.spell = true
          vim.notify('Spell check enabled')
        end
      end

      local function toggleColorscheme()
        if vim.g.colors_name == 'nordfox' then
          vim.cmd('colorscheme dawnfox')
        else
          vim.cmd('colorscheme nordfox')
        end
      end

      local function setSpelllangDe()
        vim.o.spelllang = 'de_20'
        vim.notify('Spell check language set to German')
      end

      local function setSpelllangEn()
        vim.o.spelllang = 'en'
        vim.notify('Spell check language set to English')
      end

      local wk = require('which-key')
      -- TODO: move mappings to plugin configs and only keep the +names
      wk.register({
        f = { name = '+Find' },
        x = { name = '+Diagnostics' },
        t = {
          name = '+Toggle',
          a = { '<CMD>set number!<CR>', 'Absolute Numbers' },
          r = { '<CMD>set relativenumber!<CR>', 'Relative Numbers' },
          t = { toggleLspVirtualText, 'LSP virtual text' },
          n = { '<CMD>set nonumber!<CR>', 'Line Numbers' },
          f = { toggleColorscheme, 'Colorscheme' },
          s = {
            name = '+Spell Check',
            s = { toggleSpellCheck, 'Spell Check' },
            d = { setSpelllangDe, 'Set Lang To German' },
            e = { setSpelllangEn, 'Set Lang To English' },
          },
        },
        q = { '<CMD>quit<CR>', 'Quit', mode = { 'n', 'v' } },
        Q = { '<CMD>quitall!<CR>', 'Quit All Force', mode = { 'n', 'v' } },
        h = { '<CMD>nohlsearch<CR>', 'Remove Highlight' },
        p = { '"+p', 'Paste From Clipboard', mode = { 'n', 'v' } },
        s = { ':%s///gc<left><left><left><left>', 'Substitute', silent = false },
      }, { prefix = '<leader>' })

      wk.register({
        s = { '"hy:%s/<C-r>h//gc<left><left><left>', 'Substitute Selection', silent = false },

      }, { prefix = '<leader>', mode = 'v' })

      wk.register({
        ["<C-s>"] = { '<ESC><CMD>write | quit<CR>', 'Write', mode = { 'n', 'v', 'i' } },
        Y = { '"+y', 'Yank To Clipboard', mode = { 'n', 'v' } },
        YY = { '"+yy', 'Yank Line To Clipboard', mode = { 'n' } },
      })
    end,
  },
}

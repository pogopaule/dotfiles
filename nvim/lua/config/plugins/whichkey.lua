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

      local copilot = true
      local function toggleCopilot()
        if copilot then
          vim.cmd('Copilot disable')
          vim.notify('Copilot disabled')
        else
          vim.cmd('Copilot enable')
          vim.notify('Copilot enabled')
        end
        copilot = not copilot
      end

      local function createScratchFile()
        local function randomString()
          local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
          local lowerCase = "abcdefghijklmnopqrstuvwxyz"
          local numbers = "0123456789"

          local characterSet = upperCase .. lowerCase .. numbers

          local resultLength = 5
          local result = ""

          for _ = 1, resultLength do
            local rand = math.random(#characterSet)
            result = result .. string.sub(characterSet, rand, rand)
          end
          return result
        end

        local canceledStr = "__INPUT_CANCELLED__"

        vim.ui.input({
            prompt = 'Scratch file name: ',
            cancelreturn = canceledStr,
            completion = 'file',
            default = randomString(),
          },
          function(input)
            if input == canceledStr then
              vim.cmd("echohl WarningMsg")
              vim.cmd("echomsg 'Scratch file creation cancelled!'")
              vim.cmd("echohl None")
            else
              local path = '/tmp/' .. input
              vim.cmd('edit ' .. path)
              vim.notify('Scratch file created at ' .. path)
            end
          end
        )
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
        r = { name = '+Refactor' },
        x = { name = '+Diagnostics' },
        d = { name = '+Debug' },
        T = { name = '+Tests' },
        g = {
          name = '+Git',
          b = { name = '+Blame' },
          bf = { '<CMD>G blame<CR>', 'Blame File' },
          g = { '<CMD>GBrowse<CR>', 'Open Buffer In Github' },
        },
        t = {
          name = '+Toggle',
          a = { '<CMD>set number!<CR>', 'Absolute Numbers' },
          r = { '<CMD>set relativenumber!<CR>', 'Relative Numbers' },
          t = { toggleLspVirtualText, 'LSP virtual text' },
          z = { '<CMD>ZenMode<CR>', 'ZenMode' },
          c = { toggleCopilot, 'Copilot' },
          n = { '<CMD>set nonumber!<CR>', 'Line Numbers' },
          f = { toggleColorscheme, 'Colorscheme' },
          s = {
            name = '+Spell Check',
            s = { toggleSpellCheck, 'Spell Check' },
            d = { setSpelllangDe, 'Set Lang To German' },
            e = { setSpelllangEn, 'Set Lang To English' },
          },
        },
        n = {
          name = '+New',
          s = { createScratchFile, 'Scratch' },
          t = { '<CMD>tabnew<CR>', 'Tab' },
        },
        q = { '<CMD>quit<CR>', 'Quit', mode = { 'n', 'v' } },
        Q = { '<CMD>quitall!<CR>', 'Quit All Force', mode = { 'n', 'v' } },
        h = { '<CMD>nohlsearch<CR>', 'Remove Highlight' },
        p = { '"+p', 'Paste From Clipboard', mode = { 'n', 'v' } },
        s = { ':%s///gc<left><left><left><left>', 'Substitute', silent = false },
      }, { prefix = '<leader>' })

      wk.register({
        r = {
          name = '+Refactor',
          i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
          f = { "<ESC><CMD>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
          v = { "<ESC><CMD>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
        },
        s = { '"hy:%s/<C-r>h//gc<left><left><left>', 'Substitute Selection', silent = false },

      }, { prefix = '<leader>', mode = 'v' })

      wk.register({
        ["<C-s>"] = { '<ESC><CMD>write<CR>', 'Write', mode = { 'n', 'v', 'i' } },
        Y = { '"+y', 'Yank To Clipboard', mode = { 'n', 'v' } },
        YY = { '"+yy', 'Yank Line To Clipboard', mode = { 'n' } },
      })
    end,
  },
}

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

      local function _countLineEndings(text)
        local count = 0
        for _ in text:gmatch('\n') do
          count = count + 1
        end
        return count
      end

      local function paste_preproc()
        local clipboard_content = vim.fn.getreg('+')
        if _countLineEndings(clipboard_content) == 1 then
          clipboard_content = vim.fn.substitute(clipboard_content, '\n', '', 'g')
        end
        vim.fn.setreg('s', clipboard_content)
        vim.cmd('normal! "sp')
      end

      local wk = require('which-key')
      -- TODO: move mappings to plugin configs and only keep the +names
      wk.register({
        f = {
          name = '+Find',
          c = { name = '+Commit' },
          s = { name = '+Symbol' },
        },
        r = { name = '+Refactor' },
        o = { name = '+Obsidian' },
        v = { name = '+Coverage' },
        c = { name = '+ChatGPT' },
        x = { name = '+Diagnostics' },
        d = { name = '+Debug' },
        s = { name = '+Surround' },
        T = {
          name = '+Tests',
          c = { '+Coverage' },
        },
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
          N = { '<CMD>set nonumber!<CR>', 'Line Numbers' },
          f = { toggleColorscheme, 'Colorscheme' },
          s = {
            name = '+Spell Check',
            s = { toggleSpellCheck, 'Spell Check' },
            g = { setSpelllangDe, 'Set Lang To German' },
            e = { setSpelllangEn, 'Set Lang To English' },
          },
        },
        N = {
          name = '+New',
          t = {
            name = '+Temp File',
            t =  { '<CMD>tabnew `mktemp`<CR>', 'Tab' },
            ['|'] = { '<CMD>vnew `mktemp`<CR>', '| Split' },
            ['-'] = { '<CMD>new `mktemp`<CR>', '- Split' },
          },
          b = {
            name = '+Buffer',
            t = { '<CMD>tabnew<CR>', 'Tab' },
            ['|'] = { '<CMD>vnew<CR>', '| Split' },
            ['-'] = { '<CMD>new<CR>', '- Split' },
          },
          s = {
            name = '+Scratch',
            t = { '<CMD>tabnew | setlocal buftype=nofile noswapfile bufhidden=wipe nobuflisted | Telescope filetypes<CR>', 'Tab' },
            ['|'] = { '<CMD>vnew | setlocal buftype=nofile noswapfile bufhidden=wipe nobuflisted | Telescope filetypes<CR>', '| Split' },
            ['-'] = { '<CMD>new | setlocal buftype=nofile noswapfile bufhidden=wipe nobuflisted | Telescope filetypes<CR>', '- Split' },
          },


        },
        ["<leader>"] = { '<CMD>wq<CR>', 'Save and Quit' },
        q = { '<CMD>quit<CR>', 'Quit', mode = { 'n', 'v' } },
        Q = { '<CMD>quitall!<CR>', 'Quit All Force', mode = { 'n', 'v' } },
        h = { '<CMD>nohlsearch<CR>', 'Remove Highlight' },
        p = { paste_preproc, 'Paste From Clipboard', mode = { 'n', 'v' } },
        S = { ':%s///gc<left><left><left><left>', 'Substitute', silent = false },
      }, { prefix = '<leader>' })

      wk.register({
        r = {
          name = '+Refactor',
          i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
          f = { "<ESC><CMD>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
          v = { "<ESC><CMD>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
        },
        c = { name = '+ChatGPT' },
        S = { '"hy:%s/<C-r>h//gc<left><left><left>', 'Substitute Selection', silent = false },

      }, { prefix = '<leader>', mode = 'v' })

      wk.register({
        ["<C-s>"] = { '<ESC><CMD>write<CR>', 'Write', mode = { 'n', 'v', 'i' } },
        Y = { '"+y', 'Yank To Clipboard', mode = { 'n', 'v' } },
        YY = { '"+yy', 'Yank Line To Clipboard', mode = { 'n' } },
      })
    end,
  },
}

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
      wk.add(
        {
          {
            { "<leader>N",  group = "New" },
            { "<leader>Nb", group = "Buffer" },
            { "<leader>Ns", group = "Scratch" },
            { "<leader>Nt", group = "Temp File" },
            { "<leader>T",  group = "Tests" },
            { "<leader>c",  group = "ChatGPT" },
            { "<leader>d",  group = "Debug" },
            { "<leader>f",  group = "Find" },
            { "<leader>fc", group = "Commit" },
            { "<leader>fs", group = "Symbol" },
            { "<leader>g",  group = "Git" },
            { "<leader>gb", group = "Blame" },
            { "<leader>m",  group = "Bookmark", },
            { "<leader>o",  group = "Obsidian" },
            { "<leader>r",  group = "Refactor" },
            { "<leader>t",  group = "Toggle" },
            { "<leader>ts", group = "Spell Check" },
            { "<leader>v",  group = "Coverage" },
            { "<leader>x",  group = "Diagnostics" },
            { "<leader>Tc", group = "Coverage" },
          },
          {
            mode = { "v" },
            { "<leader>c", group = "ChatGPT" },
            { "<leader>r", group = "Refactor" },
          }
        }
      )


      wk.add(
        {
          { "<leader><leader>", "<CMD>wq<CR>",                                                                                           desc = "Save and Quit" },
          { "<leader>Nb-",      "<CMD>new<CR>",                                                                                          desc = "- Split" },
          { "<leader>Nbt",      "<CMD>tabnew<CR>",                                                                                       desc = "Tab" },
          { "<leader>Nb|",      "<CMD>vnew<CR>",                                                                                         desc = "| Split" },
          { "<leader>Ns-",      "<CMD>new | setlocal buftype=nofile noswapfile bufhidden=wipe nobuflisted | Telescope filetypes<CR>",    desc = "- Split" },
          { "<leader>Nst",      "<CMD>tabnew | setlocal buftype=nofile noswapfile bufhidden=wipe nobuflisted | Telescope filetypes<CR>", desc = "Tab" },
          { "<leader>Ns|",      "<CMD>vnew | setlocal buftype=nofile noswapfile bufhidden=wipe nobuflisted | Telescope filetypes<CR>",   desc = "| Split" },
          { "<leader>Nt-",      "<CMD>new `mktemp`<CR>",                                                                                 desc = "- Split" },
          { "<leader>Ntt",      "<CMD>tabnew `mktemp`<CR>",                                                                              desc = "Tab" },
          { "<leader>Nt|",      "<CMD>vnew `mktemp`<CR>",                                                                                desc = "| Split" },
          { "<leader>S",        ":%s///gc<left><left><left><left>",                                                                      desc = "Substitute",            silent = false },
          { "<leader>gbf",      "<CMD>G blame<CR>",                                                                                      desc = "Blame File" },
          { "<leader>gg",       "<CMD>GBrowse<CR>",                                                                                      desc = "Open Buffer In Github" },
          { "<leader>h",        "<CMD>nohlsearch<CR>",                                                                                   desc = "Remove Highlight" },
          { "<leader>tN",       "<CMD>set nonumber!<CR>",                                                                                desc = "Line Numbers" },
          { "<leader>ta",       "<CMD>set number!<CR>",                                                                                  desc = "Absolute Numbers" },
          { "<leader>tc",       toggleCopilot,                                                                                           desc = "Copilot" },
          { "<leader>tf",       toggleColorscheme,                                                                                       desc = "Colorscheme" },
          { "<leader>tr",       "<CMD>set relativenumber!<CR>",                                                                          desc = "Relative Numbers" },
          { "<leader>tse",      setSpelllangEn,                                                                                          desc = "Set Lang To English" },
          { "<leader>tsg",      setSpelllangDe,                                                                                          desc = "Set Lang To German" },
          { "<leader>tss",      toggleSpellCheck,                                                                                        desc = "Spell Check" },
          { "<leader>tt",       toggleLspVirtualText,                                                                                    desc = "LSP virtual text" },
          { "<leader>tz",       "<CMD>ZenMode<CR>",                                                                                      desc = "ZenMode" },
          { "YY",               '"+yy',                                                                                                  desc = "Yank Line To Clipboard" },
          { "<C-s>",            "<ESC><CMD>write<CR>",                                                                                   desc = "Write",                 mode = { "i", "n", "v" } },
          { "Y",                '"+y',                                                                                                   desc = "Yank To Clipboard",     mode = { "n", "v" } },
          {
            mode = { "n", "v" },
            { "<leader>F", function() vim.lsp.buf.format { async = true } end, desc = "Format" },
            { "<leader>Q", "<CMD>quitall!<CR>",                                desc = "Quit All Force" },
            { "<leader>p", paste_preproc,                                      desc = "Paste From Clipboard" },
            { "<leader>q", "<CMD>quit<CR>",                                    desc = "Quit" },
          },
          {
            mode = { "v" },
            { "<leader>S", '"hy:%s/<C-r>h//gc<left><left><left>', desc = "Substitute Selection", silent = false },
          },
          {
            { mode = { "s", "x" } },
            { "<leader>F",        function() vim.lsp.buf.format { async = true } end, desc = "Format" }
          }
        }
      )
    end,
  },
}

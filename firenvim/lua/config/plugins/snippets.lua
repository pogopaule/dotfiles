return {
  {
    'https://github.com/L3MON4D3/LuaSnip',
    dependencies = {
      { 'https://github.com/rafamadriz/friendly-snippets' },
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function()
      local map = vim.keymap.set

      local ls = require('luasnip')

      -- end luasnip session after leaving insert mode
      -- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*',
        callback = function()
          if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
              and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require('luasnip').session.jump_active
          then
            require('luasnip').unlink_current()
          end
        end
      })

      -- selecting within a list of options
      map({ 'i', 's' }, '<c-e>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })

      map('i', '<c-u>', require 'luasnip.extras.select_choice')


      local types = require('luasnip.util.types')

      ls.cleanup() -- used for re-sourcing this file, otherwise you get snippet duplicates

      require('luasnip.loaders.from_vscode').lazy_load()

      ls.config.setup({
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { '🔶' } }
            }
          },
        },
      })
    end,
  },
}

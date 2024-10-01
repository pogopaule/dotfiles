return {
  -- nightfox theme
  {
    -- TODO: has upstream fixed lspsage yet?
    'https://github.com/pogopaule/nightfox.nvim',
    lazy = false,
    priority = 1000,
    build = ':NightfoxCompile',
    config = function()
      local nightfox = require('nightfox')
      nightfox.setup({
        options = {
          styles = {
            comments = 'italic',
            keywords = 'bold',
          },
        }
      })
      vim.cmd('colorscheme dawnfox')
    end
  },
  -- switch colorscheme depending on system theme
  {
    'https://github.com/f-person/auto-dark-mode.nvim',
    lazy = false,
    opts = {
      update_interval = 3000,
      set_dark_mode = function()
        vim.cmd("colorscheme nordfox")
      end,
      set_light_mode = function()
        vim.cmd("colorscheme dawnfox")
      end,
    },
  },
}

return {
  -- nightfox theme
  {
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
      if os.getenv("TERMINAL_THEME") == 'light' then
        vim.cmd('colorscheme dawnfox')
      else
        vim.cmd('colorscheme nordfox')
      end
    end
  },
}

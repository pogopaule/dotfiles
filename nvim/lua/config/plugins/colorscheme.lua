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
      if vim.loop.os_uname().sysname == 'Darwin' then
        local handle = io.popen("defaults read -g AppleInterfaceStyle")
        local result = handle:read("*a")
        handle:close()

        result = string.gsub(result, '%s+', '')

        if result == 'Dark' then
          vim.cmd('colorscheme nordfox')
        else
          vim.cmd('colorscheme dawnfox')
        end

      else
        if os.getenv("TERMINAL_THEME") == 'light' then
          vim.cmd('colorscheme dawnfox')
        else
          vim.cmd('colorscheme nordfox')
        end

      end
    end
  },
}

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

      local handle = io.open(os.getenv('HOME') .. '/.theme', 'r')
      local result = handle:read("*a")
      handle:close()
      result = string.gsub(result, "\n", "")
      if result == 'dark' then
        vim.cmd('colorscheme nordfox')
      else
        vim.cmd('colorscheme dawnfox')
      end
    end
  },
}

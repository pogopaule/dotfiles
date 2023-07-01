local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  api.config.mappings.default_on_attach(bufnr)
end

return {
  -- File Explorer
  {
    'https://github.com/kyazdani42/nvim-tree.lua',
    keys = {
      { '<leader>tN', '<CMD>NvimTreeToggle<CR>', desc = 'Nvim Tree' },
      { '<leader>N', '<CMD>NvimTreeFindFile<CR>', desc = 'Find File in Nvim Tree' },
    },
    on_attach = on_attach,
    config = {
      view = {
        width = 40,
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },
      filters = {
        dotfiles = true,
      },
      git = {
        ignore = false,
      },
      renderer = {
        special_files = {},
      },
    },
  },
}

vim.cmd [[set iskeyword+=-]]        -- e.g. delete foo-bar with daw

local options = {
  shiftwidth    = 2,                -- number of spaces for indentation
  smartindent   = true,
  expandtab     = true,             -- convert tabs to spaces

  -- relativenumber = true,            -- show relative linenumbers
  number        = true,             -- show absolute linenumbers
  cursorline    = true,             -- mark current line

  backup        = false,
  swapfile      = false,

  ignorecase    = true,             -- ignore case in search patterns
  smartcase     = true,

  updatetime    = 300,              -- faster completion and word highlighting (4000ms default)

  signcolumn    = 'yes',            -- avoid jumping leftmost column when lsp hint appear

  termguicolors = true,
  background    = 'light',

  foldlevel     = 99,
  completeopt   = {'menu', 'menuone', 'noselect'}
}

for key, value in pairs(options) do
  vim.opt[key] = value
end


-- highlight yanked region
local group = vim.api.nvim_create_augroup('highlight_yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', { command = 'lua vim.highlight.on_yank({higroup="Substitute", timeout=200})', group = group, })

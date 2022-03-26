vim.cmd [[set iskeyword+=-]]        -- e.g. delete foo-bar with daw

-- vim.cmd 'colorscheme tokyonight'
-- vim.g.tokyonight_style="day"     -- storm, night or day

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
vim.cmd[[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Substitute", timeout=200})
  augroup END
]]


-- https://github.com/vim-test/vim-test#strategies
-- vim.cmd [[let test#strategy = "neovim"]]

vim.cmd [[set iskeyword+=-]]        -- e.g. delete foo-bar with daw
vim.cmd 'colorscheme tokyonight'
vim.g.tokyonight_style="day"     -- storm, night or day

local options = {
  shiftwidth    = 2,                -- number of spaces for indentation
  tabstop       = 2,                -- number of spaces a tab counts for
  smartindent   = true,
  expandtab     = true,             -- convert tabs to spaces

  -- relativenumber = true,            -- show relative linenumbers
  number        = true,             -- show absolute linenumbers
  cursorline    = true,             -- mark current line

  ignorecase    = true,             -- ignore case in search patterns
  smartcase     = true,

  termguicolors = true,
  background    = 'light',

  foldlevel     = 99,
  completeopt   = {'menu', 'menuone', 'noselect'}
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

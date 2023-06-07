local options = {
  splitbelow = true, -- horizontal splits will automatically be below
  splitright = true, -- vertical splits will automatically be to the right

  shiftwidth  = 2, -- number of spaces for indentation
  smartindent = true,
  expandtab   = true, -- convert tabs to spaces

  relativenumber = true, -- show relative linenumbers
  number         = true, -- show absolute linenumbers
  cursorline     = true, -- mark current line

  backup   = false,
  swapfile = false,

  ignorecase = true, -- ignore case in search patterns
  smartcase  = true,

  updatetime = 300, -- faster completion and word highlighting (4000ms default)

  signcolumn = 'yes', -- avoid jumping leftmost column when lsp hint appear

  termguicolors = true,

  foldlevel   = 99,
  completeopt = { 'menu', 'menuone', 'noselect' }, -- https://github.com/hrsh7th/nvim-cmp#setup

  showmode = false, -- https://www.reddit.com/r/neovim/comments/105yfdg/hi_im_using_lualine_and_want_to_get_rid_of_the/

  timeoutlen = 300, -- so that which-key pops up faster, default is 1000

  mouse = '', -- disable mouse

  showtabline = 2, -- also show tabline when there is only one tab
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.g.user_emmet_leader_key = '<C-Z>' -- because C-Y is used by cmp

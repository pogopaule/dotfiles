local options = {
  splitbelow    = true, -- horizontal splits will automatically be below
  splitright    = true, -- vertical splits will automatically be to the right

  shiftwidth    = 2,    -- number of spaces for indentation
  smartindent   = true,
  expandtab     = true, -- convert tabs to spaces

  cursorline    = true, -- mark current line

  backup        = false,
  swapfile      = false,

  ignorecase    = true, -- ignore case in search patterns
  smartcase     = true,

  updatetime    = 300,   -- faster completion and word highlighting (4000ms default)

  signcolumn    = 'yes', -- avoid jumping leftmost column when lsp hint appear

  termguicolors = true,

  foldlevel     = 99,
  completeopt   = { 'menu', 'menuone', 'noselect' }, -- https://github.com/hrsh7th/nvim-cmp#setup

  timeoutlen    = 300,                               -- so that which-key pops up faster, default is 1000

  mouse         = '',                                -- disable mouse

  laststatus    = 0,                                 -- hide statusline

  guifont       = 'Iosevka:h12',                     -- otherwise the font is to small in the browser

  spell         = true,
  spelllang     = 'de',
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.fn.timer_start(200, function()
      if vim.api.nvim_get_option('lines') < 15 then
        vim.opt.lines = 15
      end
      vim.cmd('startinsert')
      -- if no external monitor is attached on mac, set guifont to a bigger size
      local result = vim.fn.system('system_profiler SPDisplaysDataType | grep -c "PHL"')
      if result == '0\n' then
        vim.opt.guifont = 'Iosevka:h30'
      end
    end)
  end,
})

vim.g.user_emmet_leader_key = '<C-Z>' -- because C-Y is used by cmp

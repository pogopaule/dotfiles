local wk = require('which-key')
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- disable arrow keys
map('i', '<Up>', '<NOP>', opts)
map('i', '<Down>', '<NOP>', opts)
map('i', '<Left>', '<NOP>', opts)
map('i', '<Right>', '<NOP>', opts)


-- resize splits with arrow keys
map('n', '<Up>', ':resize -4<CR>', opts)
map('n', '<Down>', ':resize +4<CR>', opts)
map('n', '<Left>', ':vertical resize -4<CR>', opts)
map('n', '<Right>', ':vertical resize +4<CR>', opts)


-- exit insert mode by pressing jk
map('i', 'jk', '<ESC>', opts)


-- enter adds new line in normal mode
map('n', '<CR>', 'o<ESC>', opts)


-- move nicer in wrapped lines
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)


-- do not overwrite yanked when pasting in visual mode
map('v', 'p', '"_dP', opts)


-- stay in indent mode when indenting
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)


-- paste visual selection at bottom of it
map('v', 'D', 'ygv<Esc>p', opts)

-- do not put single empty line in yank register
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end

map("n", "dd", smart_dd, { noremap = true, expr = true })


wk.register({
  f = {
    name = '+Find',
    f = { '<CMD>Telescope find_files hidden=true<CR>', 'Files' },
    t = { '<CMD>TodoTelescope<CR>', 'Todos' },
    h = { '<CMD>Telescope help_tags<CR>', 'Help' },
    o = { '<CMD>Telescope oldfiles<CR>', 'Old Files' },
    k = { '<CMD>Telescope keymaps<CR>', 'Keymaps' },
    s = { '<CMD>Telescope spell_suggest<CR>', 'Spelling' },
    g = { '<CMD>Telescope live_grep<CR>', 'Grep' },
    G = { '<CMD>Telescope grep_string<CR>', 'Find Word Under Cursor' },
    c = { '<CMD>Telescope git_commits<CR>', 'Git Commits' },
    b = { '<CMD>Telescope git_bcommits<CR>', 'Git Commits For Buffer' },
    r = { '<CMD>Telescope lsp_references<CR>', 'LSP references' },
    n = { '<CMD>Telekasten find_notes<CR>', 'Find Notes'},
  },
  r = {
    name = '+Refactor',
    i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
    r = { "<ESC><CMD>Lspsaga rename<CR>", 'Rename' },
  },
  d = {
    name = '+Debug',
    c = { '<CMD>DapContinue<CR>', 'Continue' },
    o = { '<CMD>DapStepOver<CR>', 'Step Over' },
    i = { '<CMD>DapStepInto<CR>', 'Step Into' },
    u = { '<CMD>DapStepOut<CR>', 'Step Out' },
    b = { '<CMD>DapToggleBreakpoint<CR>', 'Toggle Breakpoint' },
    t = { '<CMD>lua require("dapui").toggle()<CR>', 'Toggle DAP UI' },
  },
  g = {
    name = '+Git',
    r = { '<CMD>Gitsigns reset_hunk<CR>', 'Reset Hunk' },
    bl = { '<CMD>Gitsigns blame_line<CR>', 'Blame Line' },
    bf = { '<CMD>G blame<CR>', 'Blame File' },
    p = { '<CMD>Gitsigns preview_hunk<CR>', 'Preview Hunk' },
    n = { '<CMD>Gitsigns next_hunk<CR>', 'Next Hunk' },
    N = { '<CMD>Gitsigns prev_hunk<CR>', 'Previous Hunk' },
    y = { '<CMD>lua require("gitlinker").get_buf_range_url("n")<CR>', 'Github Link' },
    g = { '<CMD>GBrowse<CR>', 'Open Buffer In Github' },
  },
  x = {
    name = '+Diagnostics',
    x = { '<CMD>Trouble document_diagnostics<CR>', 'Document' },
    w = { '<CMD>Trouble workspace_diagnostics<CR>', 'Workspace' },
    n = { '<CMD>lua vim.diagnostic.goto_next({float = false})<CR>', 'Goto Next' },
    p = { '<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>', 'Goto Previous' },
  },
  l = {
    name = '+Linenumbers',
    a = { '<CMD>set number!<CR>', 'Toggle Absolute Numbers'},
    r = { '<CMD>set relativenumber!<CR>', 'Toggle Relative Numbers'},
  },
  o = {
    name = '+Open',
    k = { '<CMD>e ~/dotfiles/nvim/lua/pogopaule/keymaps.lua<CR>', 'Keymaps'},
    p = { '<CMD>e ~/dotfiles/nvim/lua/pogopaule/plugins.lua<CR>', 'Plugins'},
    s = { '<CMD>e ~/dotfiles/nvim/lua/pogopaule/plugins/luasnip.lua<CR>', 'Snippets'},
    n = { '<CMD>e ~/dotfiles/nix/home-core.nix<CR>', 'Nix Home Core'},
  },
  t = {
    name = '+Telekasten',
    f = { '<CMD>Telekasten find_notes<CR>', 'Find Notes'},
    d = { '<CMD>Telekasten find_daily_notes<CR>', 'Find Daily Notes'},
    g = { '<CMD>Telekasten search_notes<CR>', 'Grep in Notes'},
    t = { '<CMD>Telekasten panel<CR>', 'Open Panel'},
    n = { '<CMD>Telekasten new_note<CR>', 'Open Panel'},
  },
  j = {
    name = '+TSJoin',
    t = { '<CMD>TSJToggle<CR>', 'Toggle'},
    j = { '<CMD>TSJJoin<CR>', 'Join'},
    s = { '<CMD>TSJSplit<CR>', 'Split'},
  },
  q = { '<CMD>quit<CR>', 'Quit' },
  Q = { '<CMD>quitall<CR>', 'Quit All' },
  w = { '<CMD>write<CR>', 'Write' },
  h = { '<CMD>nohlsearch<CR>', 'Remove Highlight' },
  p = { '"+p', 'Paste From Clipboard' },
  a = { '<CMD>Lspsaga code_action<CR>', 'LSP Code Action' },
  e = { '<CMD>Lspsaga show_line_diagnostics<CR>', 'LSP Line Diagnostics' },
}, { prefix = "<leader>" })

wk.register({
  gd = { vim.lsp.buf.definition, 'Go to LSP definition' },
  K = { '<CMD>Lspsaga hover_doc<CR>', 'Hover LSP documentation'}
})

wk.register({
  r = {
    name = '+Refactor',
    i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
    f = { "<ESC><CMD>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
    v = { "<ESC><CMD>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
  },
  p = { '"+p', 'Paste From Clipboard' },
  y = { '"+y', 'Yank To Clipboard' },
  s = { '"hy:%s/<C-r>h//g<left><left>', 'Search Selection', silent = false },

}, { prefix = '<leader>', mode = 'v' })


-- LSP
map('n', '<C-F>', vim.lsp.buf.format, opts)
map('v', '<C-F>', vim.lsp.buf.format, opts)
map('s', '<C-F>', vim.lsp.buf.format, opts)
map('x', '<C-F>', vim.lsp.buf.format, opts)


-- akinsho/bufferline.nvim
map('n', '<A-h>', '<CMD>BufferLineCyclePrev<CR>', opts)
map('n', '<A-l>', '<CMD>BufferLineCycleNext<CR>', opts)
map('i', '<A-h>', '<CMD>BufferLineCyclePrev<CR>', opts)
map('i', '<A-l>', '<CMD>BufferLineCycleNext<CR>', opts)
map('n', '<A-H>', '<CMD>BufferLineMovePrev<CR>', opts)
map('n', '<A-L>', '<CMD>BufferLineMoveNext<CR>', opts)


-- kazhala/close-buffers.nvim
map('n', '<C-w>', "<CMD>lua require('close_buffers').delete({ type = 'this' })<CR>", opts)
map('n', '<A-o>', "<CMD>lua require('close_buffers').delete({ type = 'other' })<CR>", opts)


-- make enter work in quickfix list
local group = vim.api.nvim_create_augroup('enter_in_quickfix', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', { pattern = 'quickfix', command = 'nnoremap <buffer> <CR> <CR>', group = group, })


-- jpalardy/vim-slime
vim.cmd [[let g:slime_no_mappings = 1]]
map('x', '<C-s>', '<Plug>SlimeRegionSend', {})
map('n', '<C-s>', '<Plug>SlimeParagraphSend', {})

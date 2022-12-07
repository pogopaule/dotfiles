local wk = require('which-key')
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = ','


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


-- copy paste from system clipboard
map('n', '<leader>p', '"+p', opts)
map('v', '<leader>p', '"+p', opts)
map('v', '<leader>y', '"+y', opts)


-- search and replace in buffer
map('v', '<leader>s', '"hy:%s/<C-r>h//g<left><left>', { noremap = true })

map('n', '<leader>q', ':quit<CR>', opts)
map('n', '<leader>Q', ':quitall<CR>', opts)
map('n', '<leader>w', ':write<CR>', opts)


-- remove search highlight
map('n', '<leader>dd', ':nohlsearch<CR>', opts)


-- enter adds new line in normal mode
map('n', '<CR>', 'o<ESC>', opts)


-- move between split windows
map('n', '<C-J>', '<C-W><C-J>', opts)
map('n', '<C-K>', '<C-W><C-K>', opts)
map('n', '<C-L>', '<C-W><C-L>', opts)
map('n', '<C-H>', '<C-W><C-H>', opts)


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


local telescope_builtin = require('telescope.builtin')
local dap = require('dap')
wk.register({
  f = {
    name = '+Find',
    f = { telescope_builtin.find_files, 'Files' },
    h = { telescope_builtin.help_tags, 'Help' },
    o = { telescope_builtin.oldfiles, 'Old Files' },
    k = { telescope_builtin.keymaps, 'Keymaps' },
    t = { '<cmd>TodoTelescope<CR>', 'Todos' },
    s = { telescope_builtin.spell_suggest, 'Spelling' },
    g = { telescope_builtin.live_grep, 'Grep' },
    G = { telescope_builtin.grep_string, 'Find Word Under Cursor' },
  },
  r = {
    name = '+Refactor',
    i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
    r = { "<ESC><CMD>Lspsaga rename<CR>", 'Rename' },
  },
  d = {
    name = '+Debug',
    c = { dap.continue, 'Continue' },
    d = { dap.step_over, 'Step Over' },
    i = { dap.step_into, 'Step Into' },
    u = { dap.step_out, 'Step Out' },
    b = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
    t = { require('dapui').toggle, 'Toggle DAP UI' },
  },
  x = {
    name = '+Diagnostics',
    x = { '<CMD>Trouble document_diagnostics<CR>', 'Document' },
    w = { '<CMD>Trouble workspace_diagnostics<CR>', 'Workspace' },
    n = { '<CMD>lua vim.diagnostic.goto_next({float = false})<CR>', 'Goto Next' },
    p = { '<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>', 'Goto Previous' },
  }
}, { prefix = "<leader>" })

wk.register({
  r = {
    name = '+Refactor',
    i = { "<ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
    f = { "<ESC><CMD>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
    v = { "<ESC><CMD>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
  }
}, { prefix = '<leader>', mode = 'v' })

-- scrooloose/nerdtree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', opts)
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>', opts)


-- neovim/lspconfig
map('n', 'gd', vim.lsp.buf.definition, opts)

map('n', '<C-F>', vim.lsp.buf.format, opts)
map('v', '<C-F>', vim.lsp.buf.format, opts)
map('s', '<C-F>', vim.lsp.buf.format, opts)
map('x', '<C-F>', vim.lsp.buf.format, opts)


-- glepnir/lspsaga.nvim
map('n', '<leader>a', '<cmd>Lspsaga code_action<CR>', opts)
map('n', '<leader>cp', '<cmd>Lspsaga peek_definition<CR>', opts)
map('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
map('n', '<leader>cs', vim.lsp.buf.signature_help, opts)

-- tyru/open-browser.vim
map('n', 'gx', '<plug>(openbrowser-smart-search)', {})
map('v', 'gx', '<plug>(openbrowser-smart-search)', {})

-- map('n', '<leader>gg', '<cmd>GBrowse<CR>', opts)
wk.register({
  gg = { '<cmd>GBrowse<CR>', 'Open buffer in github' },
}, { prefix = "<leader>" })



-- akinsho/bufferline.nvim
map('n', '<A-h>', '<cmd>BufferLineCyclePrev<CR>', opts)
map('n', '<A-l>', '<cmd>BufferLineCycleNext<CR>', opts)
map('i', '<A-h>', '<cmd>BufferLineCyclePrev<CR>', opts)
map('i', '<A-l>', '<cmd>BufferLineCycleNext<CR>', opts)
map('n', '<A-H>', '<cmd>BufferLineMovePrev<CR>', opts)
map('n', '<A-L>', '<cmd>BufferLineMoveNext<CR>', opts)


-- kazhala/close-buffers.nvim
map('n', '<C-w>', "<cmd>lua require('close_buffers').delete({ type = 'this' })<cr>", opts)
map('n', '<A-o>', "<cmd>lua require('close_buffers').delete({ type = 'other' })<cr>", opts)


-- L3MON4D3/LuaSnip

-- TODO: use pure lua. need to figure out how to express the 'else <Tab>' case
vim.api.nvim_exec([[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
]], true)

local ls = require('luasnip')

map('n', '<F5>', '<CMD>source ~/dotfiles/nvim/lua/pogopaule/plugins/luasnip.lua<CR><CMD>lua require("notify")("Snippets reloaded")<CR>')

map('s', '<s-tab>', function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })

-- this always moves to the previous item within the snippet
map({ 'i', 's' }, '<s-tab>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- selecting within a list of options
map({ 'i', 's' }, '<c-e>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts)

map('i', '<c-u>', require 'luasnip.extras.select_choice')


-- make enter work in quickfix list
local group = vim.api.nvim_create_augroup('enter_in_quickfix', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', { pattern = 'quickfix', command = 'nnoremap <buffer> <CR> <CR>', group = group, })


-- folke/trouble.nvim
vim.api.nvim_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>', opts)


-- jpalardy/vim-slime
vim.cmd [[let g:slime_no_mappings = 1]]
map('x', '<C-s>', '<Plug>SlimeRegionSend', {})
map('n', '<C-s>', '<Plug>SlimeParagraphSend', {})


-- https://github.com/monaqa/dial.nvim
local dial = require('dial.map')
map('n', '<A-+>', dial.inc_normal(), opts)
map('n', '<A-->', dial.dec_normal(), opts)
map('v', '<A-+>', dial.inc_visual(), opts)
map('v', '<A-->', dial.dec_visual(), opts)
map('v', 'g<A-+>', dial.inc_gvisual(), opts)
map('v', 'g<A-->', dial.dec_gvisual(), opts)

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = ','


-- disable arrow keys
map('i', '<Up>', '<NOP>', opts)
map('i', '<Down>', '<NOP>', opts)
map('i', '<Left>', '<NOP>', opts)
map('i', '<Right>', '<NOP>', opts)
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

map('n', '<leader>dd', ':nohlsearch<CR>', opts) -- remove search highlight

map('n', '<CR>', 'o<ESC>', opts) -- enter adds new line in normal mode


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


-- stay in indent mode
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
map( "n", "dd", smart_dd, { noremap = true, expr = true } )


-- nvim-telescope/telescope.nvim
local telescope_builtin = require('telescope.builtin')
map('n', '<leader>ff', telescope_builtin.find_files, opts)
map('n', '<leader>ft', "<cmd>TodoTelescope<cr>", opts)
map('n', '<leader>fg', telescope_builtin.live_grep, opts)
map('n', '<leader>fG', telescope_builtin.grep_string, opts)
map('v', '<leader>fG', "\"zy:Telescope grep_string search=<C-r>z<cr>", opts)
map('n', '<leader>fh', telescope_builtin.help_tags, opts)
map('n', '<leader>fo', telescope_builtin.oldfiles, opts)
map('n', '<leader>fk', telescope_builtin.keymaps, opts)


-- scrooloose/nerdtree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', opts)
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>', opts)


-- ThePrimeagen/refactoring.nvim
map('v', '<leader>rf', "<Esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", opts)
map('v', '<leader>rv', "<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", opts)
map('n', '<leader>ri', "<Esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", opts)
map('v', '<leader>ri', "<Esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", opts)


-- neovim/lspconfig
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', '<leader>xn', '<cmd>lua vim.diagnostic.goto_next({float = false})<CR>', opts)
map('n', '<leader>xp', '<cmd>lua vim.diagnostic.goto_prev({float = false})<CR>', opts)

map('n', '<leader>cf', vim.lsp.buf.formatting, opts)
map('v', '<leader>cf', vim.lsp.buf.range_formatting, opts)
map('l', '<leader>cf', vim.lsp.buf.range_formatting, opts)
map('x', '<leader>cf', vim.lsp.buf.range_formatting, opts)


-- glepnir/lspsaga.nvim
map('n', '<leader>rr', '<cmd>Lspsaga rename<CR>', opts)
map('n', '<leader>a', '<cmd>Lspsaga code_action<CR>', opts)
map('n', '<leader>cp', '<cmd>Lspsaga preview_definition<CR>', opts)
map('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
map('n', 'K', require('lspsaga.hover').render_hover_doc, opts)
map('n', '<leader>cs', require('lspsaga.signaturehelp').signature_help, opts)
map("n", "<leader>fr", require("lspsaga.finder").lsp_finder, opts)

-- tyru/open-browser.vim
-- FIXME: make xdg-open work, until then this is deactivated
-- disable netrw's gx mapping.
-- vim.cmd([[
-- let g:netrw_nogx = 1
-- ]])
-- map('n', 'gx', '<plug>(openbrowser-smart-search)', {})
-- map('v', 'gx', '<plug>(openbrowser-smart-search)', {})

map('n', '<leader>gg', '<cmd>GBrowse<CR>', opts)


-- lewis6991/gitsigns.nvim
map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', opts)
map('n', '<leader>gb', '<cmd>Gitsigns blame_line<CR>', opts)
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
map('n', '<leader>gn', '<cmd>Gitsigns next_hunk<CR>', opts)
map('n', '<leader>gN', '<cmd>Gitsigns prev_hunk<CR>', opts)


-- akinsho/bufferline.nvim
map('n', '<A-h>', '<cmd>BufferLineCyclePrev<CR>', opts)
map('n', '<A-l>', '<cmd>BufferLineCycleNext<CR>', opts)
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

vim.keymap.set({ "s" }, "<s-tab>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })

-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<s-tab>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- selecting within a list of options
vim.keymap.set({'i', 's'}, "<c-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts)

vim.keymap.set('i', '<c-u>', require 'luasnip.extras.select_choice')

-- make enter work in quickfix list
vim.api.nvim_exec([[
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
]], true)


-- folke/trouble.nvim
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble document_diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>', opts)


-- renerocksai/telekasten.nvim
local telekasten = require('telekasten')
map('n', '<leader>zf', telekasten.find_notes, opts)
map('n', '<leader>zd', telekasten.find_daily_notes, opts)
map('n', '<leader>zg', telekasten.search_notes, opts)
map('n', '<leader>zz', telekasten.follow_link, opts)
map('n', '<leader>zT', telekasten.goto_today, opts)
map('n', '<leader>zn', telekasten.new_note, opts)
map('n', '<leader>zN', telekasten.new_templated_note, opts)
map('n', '<leader>zc', telekasten.show_calendar, opts)
map('n', '<leader>zi', telekasten.insert_link, opts)
map('n', '<leader>zt', telekasten.toggle_todo, opts)
map('n', '<leader>zb', telekasten.show_backlinks, opts)
map('n', '<leader>zF', telekasten.find_friends, opts)
map('n', '<leader>z#', telekasten.show_tags, opts)
map('n', '<leader>zr', telekasten.rename_note, opts)
map('n', '<leader>z',  telekasten.panel, opts) --  on hesitation, bring up the panel


-- jpalardy/vim-slime
vim.cmd[[let g:slime_no_mappings = 1]]
map('x', '<C-s>', '<Plug>SlimeRegionSend', {})
map('n', '<C-s>', '<Plug>SlimeParagraphSend', {})


-- mfussenegger/nvim-dap
local dap = require('dap')
map('n', '<leader>dc', dap.continue, opts)
map('n', '<leader>dv', dap.step_over, opts)
map('n', '<leader>di', dap.step_into, opts)
map('n', '<leader>du', dap.step_out, opts)
map('n', '<leader>db', dap.toggle_breakpoint, opts)
-- map('n', '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
-- map('n', '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
-- map('n', '<Leader>dr', "<Cmd>lua require'dap'.repl.open()<CR>", opts)
-- map('n', '<Leader>dl', "<Cmd>lua require'dap'.run_last()<CR>", opts)

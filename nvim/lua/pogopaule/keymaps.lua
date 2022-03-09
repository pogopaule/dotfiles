local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

vim.g.mapleader = ","

-- disable arrow keys
map('i', '<Up>', 'NOP', opts)
map('i', '<Down>', 'NOP', opts)
map('i', '<Left>', 'NOP', opts)
map('i', '<Right>', 'NOP', opts)
map('n', '<Up>', 'NOP', opts)
map('n', '<Down>', 'NOP', opts)
map('n', '<Left>', 'NOP', opts)
map('n', '<Right>', 'NOP', opts)

map('i', 'jk', '<ESC>', opts) -- exit insert mode by pressing jk

-- copy paste from system clipboard
map('n', '<leader>p', '"+p', opts)
map('v', '<leader>p', '"+p', opts)
map('v', '<leader>y', '"+y', opts)

map('n', '<leader>s', ':%s/<C-r><C-w>//g<Left><Left>', { noremap = true }) -- search and replace in buffer

map('n', '<leader>q', ':quit<CR>', opts)
map('n', '<leader>Q', ':quitall<CR>', opts)
map('n', '<leader>w', ':write<CR>', opts)

map('n', '<leader>d', ':nohlsearch<CR>', opts) -- remove search highlight

map('n', '<CR>', 'o<ESC>', opts) -- enter adds new line in normal mode

-- move between split windows
map('n', '<C-J>', '<C-W><C-J>', opts)
map('n', '<C-K>', '<C-W><C-K>', opts)
map('n', '<C-L>', '<C-W><C-L>', opts)
map('n', '<C-H>', '<C-W><C-H>', opts)

-- move nicer in wrapped lines
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

map('v', 'p', '"_dP', opts) -- do not overwrite yanked when pasting in visual mode

-- stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)



-- nvim-telescope/telescope.nvim
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map('n', '<leader>ft', "<cmd>TodoTelescope<cr>", opts)
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map('n', '<leader>fG', "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)
map('v', '<leader>fG', "\"zy:Telescope grep_string search=<C-r>z<cr>", opts)
map('n', '<leader>fr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
map('n', '<leader>fi', "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)

-- scrooloose/nerdtree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', opts)
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>', opts)

-- ThePrimeagen/refactoring.nvim
map('v', '<leader>rf', "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", opts)
map('v', '<leader>rv', "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>", opts)
map('n', '<leader>ri', "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", opts)
map('v', '<leader>ri', "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", opts)

-- neovim/lspconfig
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', '<leader>xn', '<cmd>lua vim.diagnostic.goto_next({float = false})<CR>', opts)
map('n', '<leader>xp', '<cmd>lua vim.diagnostic.goto_prev({float = false})<CR>', opts)

map('n', '<C-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
map('v', '<C-f>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
map('l', '<C-f>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
map('x', '<C-f>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

-- tami5/lspsaga.nvim
map('n', '<leader>rr', '<cmd>Lspsaga rename<CR>', opts)
map('n', '<leader>a', '<cmd>Lspsaga code_action<CR>', opts)
map('n', '<leader>cp', '<cmd>Lspsaga preview_definition<CR>', opts)
map('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
map('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
map('n', '<leader>cs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)

-- tyru/open-browser-github.vim
-- disable netrw's gx mapping.
vim.cmd([[
let g:netrw_nogx = 1
]])
map('n', 'gx', '<plug>(openbrowser-smart-search)', {})
map('v', 'gx', '<plug>(openbrowser-smart-search)', {})
map('n', 'gxx', '<cmd>GBrowse<CR>', opts)

-- lewis6991/gitsigns.nvim
map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', opts)
map('n', '<leader>gb', '<cmd>Gitsigns blame_line<CR>', opts)
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
map('n', '<leader>gn', '<cmd>Gitsigns next_hunk<CR>', opts)
map('n', '<leader>gN', '<cmd>Gitsigns prev_hunk<CR>', opts)

-- akinsho/bufferline.nvim
map('n', '<A-h>', '<cmd>BufferLineCyclePrev<CR>', opts)
map('n', '<A-l>', '<cmd>BufferLineCycleNext<CR>', opts)

-- kazhala/close-buffers.nvim
map('n', '<C-w>', "<cmd>lua require('close_buffers').delete({ type = 'this' })<cr>", opts)
map('n', '<A-o>', "<cmd>lua require('close_buffers').delete({ type = 'other' })<cr>", opts)

-- hrsh7th/vim-vsnip
vim.api.nvim_exec([[
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
"nmap        s   <Plug>(vsnip-select-text)
"xmap        s   <Plug>(vsnip-select-text)
nmap        <C-s>   <Plug>(vsnip-cut-text)
xmap        <C-s>   <Plug>(vsnip-cut-text)
]], true)

-- make enter work in quickfix list
vim.api.nvim_exec([[
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
]], true)


-- folke/trouble.nvim
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble document_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

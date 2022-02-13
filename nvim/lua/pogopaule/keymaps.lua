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

map('n', '<leader>t', ':tabnew<CR>', opts)

-- copy paste from system clipboard
map('n', '<leader>p', '"+p', opts)
map('v', '<leader>y', '"+y', opts)

map('n', '<leader>s', ':%s/<C-r><C-w>//g<Left><Left>', { noremap = true }) -- search and replace in buffer

map('n', '<leader>q', ':quit<CR>', opts)
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
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
map('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles()<cr>", opts)
map('n', '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>", opts)
map('n', '<leader>fr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)

-- scrooloose/nerdtree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', opts)
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>', opts)

-- neovim/lspconfig
map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

-- tami5/lspsaga.nvim
map('n', '<leader>cr', '<cmd>Lspsaga rename<CR>', opts)
map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
map('n', '<leader>cd', '<cmd>Lspsaga hover_doc<CR>', opts)
map('n', '<leader>cp', '<cmd>Lspsaga preview_definition<CR>', opts)
map('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- tyru/open-browser-github.vim
vim.cmd([[
let g:netrw_nogx = 1 " disable netrw's gx mapping.
]])
map('n', 'gx', '<cmd>OpenBrowserSmartSearch<CR>', opts)
map('v', 'gx', '<cmd>OpenBrowserSmartSearch<CR>', opts)
map('n', 'gxx', '<cmd>OpenGithubFile<CR>', opts)

-- TODO
--" hrsh7th/vim-vsnip
--
--" Expand
--imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
--smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
--
--" Expand or jump
--imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
--smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
--
--" Jump forward or backward
--imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
--smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
--imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
--smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
--
--" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
--" See https://github.com/hrsh7th/vim-vsnip/pull/50
--nmap        s   <Plug>(vsnip-select-text)
--xmap        s   <Plug>(vsnip-select-text)
--nmap        S   <Plug>(vsnip-cut-text)
--xmap        S   <Plug>(vsnip-cut-text)
--
--" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
--let g:vsnip_filetypes = {}
--let g:vsnip_filetypes.javascriptreact = ['javascript']
--let g:vsnip_filetypes.typescriptreact = ['typescript']

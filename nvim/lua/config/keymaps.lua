local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- disable arrow keys
map('i', '<Up>', '<NOP>', opts)
map('i', '<Down>', '<NOP>', opts)
map('i', '<Left>', '<NOP>', opts)
map('i', '<Right>', '<NOP>', opts)


-- insert line ending like ; and new line
local function insert_line_ending_and_nl()
  local ending = ";"
  local ft = vim.bo.filetype
  if ft == "json" or ft == "lua" then
    ending = ","
  end
  return "<Esc>A" .. ending .. "<Esc>o"
end

-- insert line ending like ;
local function insert_line_ending()
  local ending = ";"
  local ft = vim.bo.filetype
  if ft == "json" or ft == "lua" then
    ending = ","
  end
  return "<Esc>miA" .. ending .. "<Esc>`ii"
end

map({ 'n', 'i' }, '<A-CR>', insert_line_ending_and_nl, { expr = true, silent = true, noremap = true })
map( 'i' , '<A-,>', insert_line_ending, { expr = true, silent = true, noremap = true })


-- resize splits with arrow keys
map('n', '<Up>', ':resize -4<CR>', opts)
map('n', '<Down>', ':resize +4<CR>', opts)
map('n', '<Left>', ':vertical resize -4<CR>', opts)
map('n', '<Right>', ':vertical resize +4<CR>', opts)

-- move between tab
map({ 'n', 'v' }, '<A-h>', '<CMD>tabprevious<CR>', opts)
map({ 'n', 'v' }, '<A-l>', '<CMD>tabnext<CR>', opts)
map({ 'n', 'v' }, '<C-w>', "<CMD>tabclose<CR>", opts)


-- map folding to space
map('n', '<space>', 'za', opts)


-- exit insert mode by pressing jk
map('i', 'jk', '<ESC>', opts)


-- enter adds new line in normal mode
map('n', '<CR>', 'o<ESC>', opts)


-- move nicer in wrapped lines
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })


-- do not overwrite yanked when pasting in visual mode
map('x', 'p', '"_dP', opts)


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

-- make enter work in quickfix list
local group = vim.api.nvim_create_augroup('enter_in_quickfix', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost',
  { pattern = 'quickfix', command = 'nnoremap <buffer> <CR> <CR>', group = group, })

-- LSP
map('n', '<C-F>', vim.lsp.buf.format, opts)
map('v', '<C-F>', vim.lsp.buf.format, opts)
map('s', '<C-F>', vim.lsp.buf.format, opts)
map('x', '<C-F>', vim.lsp.buf.format, opts)

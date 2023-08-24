local opts = { noremap = true, silent = true }
local map = vim.keymap.set


-- jump to end of seletion after yanking
map('v', 'y', 'myy`y', opts)

-- disable arrow keys
map('i', '<Up>', '<NOP>', opts)
map('i', '<Down>', '<NOP>', opts)
map('i', '<Left>', '<NOP>', opts)
map('i', '<Right>', '<NOP>', opts)

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

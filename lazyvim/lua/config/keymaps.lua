-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- exit insert mode by pressing jj
vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set({ "n", "v", "i" }, "<C-PageUp>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set({ "n", "v", "i" }, "<C-PageDown>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "v", "i" }, "<C-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "v", "i" }, "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set({ "n", "v" }, "<C-w>", Snacks.bufdelete, { desc = "Delete Buffer" })

vim.keymap.set("i", "<C-b>", "<ESC>viwUgi", { desc = "Upper case word" })

vim.keymap.set("n", "<space>", "za", { desc = "Toggle fold" })

vim.keymap.set("n", "<CR>", "o<ESC>", { desc = "New line below" })

vim.keymap.set("x", "D", "ygv<Esc>p", { desc = "Dupclicate visual selection" })

-- do not put single empty line in yank register
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end

vim.keymap.set("n", "dd", smart_dd, { desc = "Smart delete line", expr = true })

-- do not put changed text in yank register
vim.keymap.set("n", "c", '"_c')

-- I want to use L and H to move the cursor to the top or bottom of the buffer
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

local virtual_text_toggle = Snacks.toggle({
  name = "LSP Virtual Text",
  get = function()
    return vim.diagnostic.config().virtual_text
  end,
  set = function(state)
    if state then
      vim.diagnostic.config({ virtual_text = true })
    else
      vim.diagnostic.config({ virtual_text = false })
    end
  end,
}):map("<leader>uD")

vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")
vim.keymap.set("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

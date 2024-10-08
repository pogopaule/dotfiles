-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- exit insert mode by pressing jk
vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set({ "n", "v", "i" }, "<C-PageUp>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set({ "n", "v", "i" }, "<C-PageDown>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "v", "i" }, "<C-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "v", "i" }, "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set({ "n", "v" }, "<C-w>", LazyVim.ui.bufremove, { desc = "Delete Buffer" })

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

-- I want to use L and H to move the cursor to the top or bottom of the buffer
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

local util_toggle = require("lazyvim.util.toggle")
local virtual_text_toggle = util_toggle.wrap({
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
})

LazyVim.toggle.map("<leader>uD", virtual_text_toggle)

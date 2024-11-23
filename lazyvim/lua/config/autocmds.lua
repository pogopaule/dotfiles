-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local notify = require("notify")

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    local register = vim.fn.reg_recording()
    notify("Recording macro to register: " .. register, "info", {
      title = "Macro Recording Started",
    })
  end,
})

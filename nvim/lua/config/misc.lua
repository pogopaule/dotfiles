-- for awesome-sustainability-jobs
vim.api.nvim_create_user_command('PasteGeo', 'normal "+p0f:lldf@f,f,DF,xDj0$p', {})


-- highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

 -- e.g. delete foo-bar with daw
vim.cmd [[set iskeyword+=-]]

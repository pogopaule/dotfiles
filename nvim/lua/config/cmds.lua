-- for awesome-sustainability-jobs
vim.api.nvim_create_user_command('PasteGeo', 'normal "+p0f:lldf@f,f,DF,xDj0$p', {})

-- small helper commands
vim.api.nvim_create_user_command(
  'DeleteEmptyLines',
  function(arg)
    if arg.range ~= 0 then
      vim.api.nvim_exec(string.format("%s,%sg/^$/d", arg.line1, arg.line2), {});
    else
      vim.api.nvim_exec("g/^$/d", {});
    end
  end,
  { range = true }
)

-- highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

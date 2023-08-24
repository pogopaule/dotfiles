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

 -- e.g. delete foo-bar with daw
vim.cmd [[set iskeyword+=-]]

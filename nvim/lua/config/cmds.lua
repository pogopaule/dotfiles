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

local function foobar(command)
  -- Ensure that Treesitter is available
  if not pcall(require, 'nvim-treesitter') then
    print("Treesitter is not available.")
    return
  end

  -- Get the current buffer's file name
  local file_path = vim.api.nvim_buf_get_name(0)

  -- Make the file path relative to the current working directory
  local relative_path = vim.fn.fnamemodify(file_path, ':.')

  -- Get the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1] - 1 -- Treesitter counts rows from 0
  local col = cursor_pos[2]

  -- Get the Treesitter node at the current cursor position
  local parser = vim.treesitter.get_parser(0)
  local tstree = parser:parse()[1]

  local root = tstree:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  -- Traverse up the syntax tree to find the test function that contains the node
  local test_name = nil
  while node do
    if node:type() == "function_definition" then
      local name_node = node:field("name")[1]
      if name_node then
        local name = vim.treesitter.get_node_text(name_node, 0)
        if name and name:match("^test_") then
          test_name = name
          break
        end
      end
    end
    node = node:parent()
  end

  -- Construct the pytest command with the relative path and optional test method name
  local pytest_command = command .. " " .. relative_path
  if test_name then
    pytest_command = pytest_command .. "::" .. test_name
  end

  vim.fn.system("tmux send-keys -t .+ " .. vim.fn.shellescape(pytest_command) .. " C-m")

  -- Copy the command to the clipboard
  vim.fn.setreg('+', pytest_command)
end

local function pytest()
  foobar("pytest")
end

local function coverage()
  foobar("coverage run -m pytest")
end

vim.api.nvim_create_user_command(
  'Pytest',
  pytest,
  {}
)

vim.api.nvim_create_user_command(
  'PytestCoverage',
  coverage,
  {}
)

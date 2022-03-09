local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

local eslintConfig = {
  condition = function(utils)
    return utils.root_has_file({
      '.eslintrc.cjs',
      '.eslintrc.js',
      '.eslintrc.json',
      '.eslintrc.yaml',
      '.eslintrc.yml',
    })
  end
}

local prettierConfig = {
  condition = function(utils)
    return utils.root_has_file('.prettierrc')
  end
}

null_ls.setup({
  debug = false,
  sources = {
    -- formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.stylua,
    -- diagnostics.flake8
    formatting.eslint_d.with(eslintConfig),
    diagnostics.eslint_d.with(eslintConfig),
    code_actions.eslint_d.with(eslintConfig),

    formatting.prettier.with(prettierConfig),

    diagnostics.vale.with({
      filetypes = { "markdown", "text", "gitcommit", "asciidoc"},
      args = { "--no-exit", "--output=JSON", "$FILENAME", "--minAlertLevel=suggestion" },
    }),
  },
})

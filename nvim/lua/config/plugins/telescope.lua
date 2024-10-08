local find_django_others = function()
  local notify = require('notify')

  local utils = require('telescope.utils')
  local current_directory = utils.buffer_dir()

  while true do
    if current_directory == '/' or string.match(current_directory, 'webserver$') then
      notify('Cannot find other files')
      break
    end

    local file_to_test = current_directory .. '/apps.py'
    if vim.fn.filereadable(file_to_test) == 1 then
      return require('telescope.builtin').find_files({
        cwd = current_directory,
      })
    end

    -- Go up the directory hierarchy
    current_directory = vim.fn.fnamemodify(current_directory, ":h")
  end
end

local function telescope_dynamic_workspace_symbols_under_cursor()
  local word = vim.fn.expand('<cword>')
  vim.cmd('Telescope lsp_workspace_symbols query=' .. word)
end

return {
  {
    'https://github.com/nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'https://github.com/nvim-telescope/telescope-symbols.nvim',
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
      'https://github.com/Marskey/telescope-sg',
      'https://github.com/nvim-telescope/telescope-live-grep-args.nvim',
    },
    keys = {
      { '<leader>ff',  '<CMD>Telescope find_files<CR>',                                                desc = 'Files' },
      { '<leader>fh',  '<CMD>Telescope help_tags<CR>',                                                 desc = 'Help' },
      { '<leader>fa',  '<CMD>Telescope oldfiles<CR>',                                                  desc = 'Old Files' },
      { '<leader>fd',  find_django_others,                                                             desc = 'Django Other Files' },
      { '<leader>fk',  '<CMD>Telescope keymaps<CR>',                                                   desc = 'Keymaps' },
      { '<leader>fS',  '<CMD>Telescope spell_suggest<CR>',                                             desc = 'Spelling' },
      { '<leader>fg',  '<CMD>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', desc = 'Grep' },
      { '<leader>fG',  '<CMD>Telescope grep_string<CR>',                                               desc = 'Find Word Under Cursor' },
      { '<leader>fcp', '<CMD>Telescope git_commits<CR>',                                               desc = 'Git Commits For Project' },
      { '<leader>fcb', '<CMD>Telescope git_bcommits<CR>',                                              desc = 'Git Commits For Buffer' },
      { '<leader>fb',  '<CMD>Telescope buffers<CR>',                                                   desc = 'Buffers' },
      { '<leader>f:',  '<CMD>Telescope command_history<CR>',                                           desc = 'Command History' },
      { '<leader>f/',  '<CMD>Telescope current_buffer_fuzzy_find<CR>',                                 desc = 'Fuzzy Find In Current Buffer' },
      { '<leader>fm',  '<CMD>Telescope resume<CR>',                                                    desc = 'Resume' },
      { '<leader>fss', '<CMD>Telescope lsp_document_symbols<CR>',                                      desc = 'Document Symbols' },
      { '<leader>fsw', '<CMD>Telescope lsp_dynamic_workspace_symbols<CR>',                             desc = 'Workspace Symbols' },
      { '<leader>fsc', '<CMD>Telescope lsp_dynamic_workspace_symbols symbols=class<CR>',               desc = 'Classes in Workspace' },
      { '<leader>fsu', telescope_dynamic_workspace_symbols_under_cursor,                               desc = 'Symbol under Cursor in Workspace' },
    },
    config = function()
      local telescope = require('telescope')
      local telescope_actions = require('telescope.actions')
      local lga_actions = require("telescope-live-grep-args.actions")
      telescope.setup {
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                -- freeze the current list and start a fuzzy search in the frozen list
                ["<C-f>"] = telescope_actions.to_fuzzy_refine,
              },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
          },
          ['ui-select'] = { require('telescope.themes').get_dropdown {} },
          ast_grep = {
            command = {
              "sg",
              "--json=stream",
            },                       -- must have --json=stream
            grep_open_files = false, -- search in opened files
            lang = nil,              -- string value, specify language for ast-grep `nil` for default
          }
        },
        defaults = {
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          mappings = {
            i = {
              ["<C-i>"] = function()
                require("telescope.builtin").find_files({ no_ignore = true })
              end,
              ["<C-h>"] = function()
                require("telescope.builtin").find_files({ hidden = true })
              end,
              ["<C-f>"] = telescope_actions.to_fuzzy_refine,
            },
          },
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
      telescope.load_extension('ui-select')

      -- https://github.com/rcarriga/nvim-notify#viewing-history
      telescope.load_extension('notify')
      telescope.load_extension('ast_grep')
      telescope.load_extension('harpoon')
      telescope.load_extension('live_grep_args')
    end
  },
}

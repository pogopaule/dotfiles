local find_django_others = function()
  local notify = require('notify')

  local utils = require('telescope.utils')
  local current_directory = utils.buffer_dir()

  while true do
    if current_directory == '/' or string.match(current_directory, 'webserver$') then
      notify('Cannot find other files')
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

return {
  {
    'https://github.com/folke/flash.nvim',
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T" }, -- this removes ',' from the list, which I use as the leader key
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
    },
  },

  -- Find, Filter, Preview, Pick
  {
    'https://github.com/nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'https://github.com/nvim-telescope/telescope-symbols.nvim',
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      { '<leader>ff',  '<CMD>Telescope find_files<CR>',                    desc = 'Files' },
      { '<leader>fh',  '<CMD>Telescope help_tags<CR>',                     desc = 'Help' },
      { '<leader>fo',  '<CMD>Telescope oldfiles<CR>',                      desc = 'Old Files' },
      { '<leader>fd',  find_django_others,                                 desc = 'Django Other Files' },
      { '<leader>fk',  '<CMD>Telescope keymaps<CR>',                       desc = 'Keymaps' },
      { '<leader>fS',  '<CMD>Telescope spell_suggest<CR>',                 desc = 'Spelling' },
      { '<leader>fg',  '<CMD>Telescope live_grep<CR>',                     desc = 'Grep' },
      { '<leader>fG',  '<CMD>Telescope grep_string<CR>',                   desc = 'Find Word Under Cursor' },
      { '<leader>fcp', '<CMD>Telescope git_commits<CR>',                   desc = 'Git Commits For Project' },
      { '<leader>fcb', '<CMD>Telescope git_bcommits<CR>',                  desc = 'Git Commits For Buffer' },
      { '<leader>fb',  '<CMD>Telescope buffers<CR>',                       desc = 'Buffers' },
      { '<leader>f:',  '<CMD>Telescope command_history<CR>',               desc = 'Command History' },
      { '<leader>f/',  '<CMD>Telescope current_buffer_fuzzy_find<CR>',     desc = 'Fuzzy Find In Current Buffer' },
      { '<leader>fss', '<CMD>Telescope lsp_document_symbols<CR>',          desc = 'Find Document Symbols' },
      { '<leader>fsw', '<CMD>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Find Workspace Symbols' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown {} }
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
            },
          },
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call load_extension, somewhere after setup function:
      telescope.load_extension('ui-select')

      -- https://github.com/rcarriga/nvim-notify#viewing-history
      telescope.load_extension('notify')
    end
  },


  -- Seamless jumping between vim and tmux
  {
    'https://github.com/alexghergh/nvim-tmux-navigation',
    keys = {
      {
        '<C-h>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<CR>",
        desc = 'Tmux Left',
        mode = { 'n', 'v', 'i' }
      },
      {
        '<C-j>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<CR>",
        desc = 'Tmux Down',
        mode = { 'n', 'v', 'i' }
      },
      {
        '<C-k>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<CR>",
        desc = 'Tmux Up',
        mode = { 'n', 'v', 'i' }
      },
      {
        '<C-l>',
        "<CMD>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<CR>",
        desc = 'Tmux Right',
        mode = { 'n', 'v', 'i' }
      },
    },
    config = function()
      require('nvim-tmux-navigation').setup({})
    end
  },

}

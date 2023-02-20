return {
  {
    'https://github.com/folke/zen-mode.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = {
      window = {
        width = 150,
      },
      plugins = {
        twilight = { enabled = true }
      }
    },
    dependencies = {
      { 'https://github.com/folke/twilight.nvim' }
    }
  },

  -- snake_case to camelCase and more
  {
    'https://github.com/johmsalas/text-case.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('textcase').setup({})
    end
    -- config = true,
    -- keys = {
    --   { '<leader>cu', '<CMD>lua require("textcase").current_word("to_upper_case")<CR>', desc = 'TO UPPER CASE' },
    --   { '<leader>cl', '<CMD>lua require("textcase").current_word("to_lower_case")<CR>', desc = 'to lower case' },
    --   { '<leader>cs', '<CMD>lua require("textcase").current_word("to_snake_case")<CR>', desc = 'to_snake_case' },
    --   { '<leader>cd', '<CMD>lua require("textcase").current_word("to_dash_case")<CR>', desc = 'to-dash-case' },
    --   { '<leader>cn', '<CMD>lua require("textcase").current_word("to_constant_case")<CR>', desc = 'TO_CONSTANT_CASE' },
    --   { '<leader>cd', '<CMD>lua require("textcase").current_word("to_dot_case")<CR>', desc = 'to.dot.case' },
    --   { '<leader>ca', '<CMD>lua require("textcase").current_word("to_phrase_case")<CR>', desc = 'To phrase case' },
    --   { '<leader>cc', '<CMD>lua require("textcase").current_word("to_camel_case")<CR>', desc = 'toCamelCase' },
    --   { '<leader>cp', '<CMD>lua require("textcase").current_word("to_pascal_case")<CR>', desc = 'ToPascalCase' },
    --   { '<leader>ct', '<CMD>lua require("textcase").current_word("to_title_case")<CR>', desc = 'To Title Case' },
    --   { '<leader>cf', '<CMD>lua require("textcase").current_word("to_path_case")<CR>', desc = 'to/path/case' },
    -- }
  },

  -- project wide search/replace
  {
    'https://github.com/nvim-pack/nvim-spectre',
    config = function()
      require('spectre').setup()
    end,
  },

  -- ChatGPT
  {
    'https://github.com/jackMort/ChatGPT.nvim',
    config = {
      welcome_message = '',
    },
    keys = {
      { '<leader>c', '<CMD>ChatGPT<CR>', desc = 'ChatGPT' },
    },
    dependencies = { 'https://github.com/MunifTanjim/nui.nvim' }
  },

  -- undo tree in telescope
  {
    'https://github.com/debugloop/telescope-undo.nvim',
    keys = {
      { '<leader>fu', '<CMD>Telescope undo<CR>', desc = 'Undo' },
    },
    config = function()
      require('telescope').load_extension('undo')
    end,
  },

  -- better folding
  {
    'https://github.com/kevinhwang91/nvim-ufo',
    lazy = false,
    dependencies = 'https://github.com/kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      -- Option 3: treesitter as a main provider instead
      -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'indent' }
        end
      })
    end
  },

  -- fixes indentation problems with bullet lists
  {
    'https://github.com/dkarter/bullets.vim',
    ft = 'markdown',
  },

  -- treesitter playground, show syntax tree
  {
    'https://github.com/nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  },

  -- github integration
  {
    'https://github.com/pwntester/octo.nvim',
    cmd = 'Octo',
    config = true,
  },

  -- -- editorconfig integration
  -- { 'https://github.com/editorconfig/editorconfig-vim' },

  -- -- use vscode's container definitions in nvim
  -- { 'https://github.com/jamestthompson3/nvim-remote-containers' },

  -- measure startup time
  {
    'https://github.com/dstein64/vim-startuptime',
    cmd = "StartupTime",
  },

  -- translate text
  {
    'https://github.com/potamides/pantran.nvim',
    cmd = 'Pantran',
    config = {
      default_engine = 'deepl',
      engines = { deepl = { default_target = 'de' } },
    },
  },

  -- enhanced inc/dec
  {
    'https://github.com/monaqa/dial.nvim',
    keys = {
      {
        "+",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = 'Dial Increment',
      },
      {
        "-",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = 'Dial Decrement',
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.constant.alias.bool,
        },
      }
    end
  },
}

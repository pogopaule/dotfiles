return {
  {
    'https://github.com/m4xshen/hardtime.nvim',
    dependencies = {
      "https://github.com/MunifTanjim/nui.nvim",
      "https://github.com/nvim-lua/plenary.nvim",
    },
    opts = {},
    lazy = false,
  },
  {
    'https://github.com/subnut/nvim-ghost.nvim',
    lazy = false,
  },
  {
    'https://github.com/AckslD/nvim-neoclip.lua',
    event = 'VeryLazy',
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
    end,
  },
  {
    'https://github.com/sindrets/diffview.nvim',
    lazy = false,
    conifg = true,
  },
  {
    'https://github.com/rgroli/other.nvim',
    cmd = { 'Other', 'OtherSplit', 'OtherVSplit' },
    keys = {
      { '<leader>o', '<CMD>Other<CR>', desc = 'Other' },
    },
    config = function()
      local file_types = { 'models', 'enums', 'api', 'urls', 'apps', 'constants', 'encoders', 'mixins', 'serializers',
        'exceptions', 'validators', 'tasks', 'admin', 'filters', 'services', 'utils', 'test/factories', }
      local mappings_combinations = {}
      for _, file_type in ipairs(file_types) do
        local targets = {}
        for _, target in ipairs(file_types) do
          if target ~= file_type then
            table.insert(targets, {
              target = "%1/" .. target .. ".py",
              context = target,
            })
          end
        end

        table.insert(mappings_combinations, {
          pattern = "(.*)/" .. file_type .. ".py$",
          target = targets,
        })
      end

      table.insert(mappings_combinations, {
        pattern = "(.*)/test/test_(.*).py$",
        target = "%1/%2.py",
      })

      table.insert(mappings_combinations, {
        pattern = "(.*)/(.*).py$",
        target = "%1/test/test_%2.py",
        context = "test",
      })

      require("other-nvim").setup({
        mappings = mappings_combinations,
        showMissingFiles = false,
        rememberBuffers = false,
      })
    end
  },
  {
    'https://github.com/nvim-neotest/neotest',
    dependencies = {
      { 'https://github.com/nvim-neotest/neotest-python' },
    },
    ft = { 'python' },
    keys = {
      { '<leader>TT', '<CMD>write | lua require("neotest").run.run()<CR>',                   desc = 'Nearest' },
      { '<leader>Tf', '<CMD>write | lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'File' },
      { '<leader>Ta', '<CMD>lua require("neotest").run.attach()<CR>',                        desc = 'Attach' },
      { '<leader>Tx', '<CMD>lua require("neotest").run.stop()<CR>',                          desc = 'Stop Nearest' },
      { '<leader>Ts', '<CMD>lua require("neotest").summary.toggle()<CR>',                    desc = 'Toggle Summary' },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            python = "python",
            runner = "pytest",
          }),
        },
        quickfix = {
          open = false,
        },
      })
    end,
  },
  {
    'https://github.com/rmagatti/auto-session',
    config = true,
  },
  {
    'https://github.com/james1236/backseat.nvim',
    lazy = false,
    config =
    {
      openai_model_id = 'gpt-3.5-turbo', --gpt-4 (If you do not have access to a model, it says "The model does not exist")
      -- language = 'english', -- Such as 'japanese', 'french', 'pirate', 'LOLCAT'
      -- split_threshold = 100,
      -- additional_instruction = "Respond snarkily", -- (GPT-3 will probably deny this request, but GPT-4 complies)
      -- highlight = {
      --     icon = '', -- ''
      --     group = 'Comment',
      -- }
    }
  },
  {
    'https://github.com/simrat39/rust-tools.nvim',
    config = true,
    ft = 'rust',
  },
  {
    'https://github.com/folke/zen-mode.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'ZenMode' },
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
      require('textcase').setup {}
      require('telescope').load_extension('textcase')
      vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
      vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end
  },

  -- ChatGPT
  {
    'https://github.com/jackMort/ChatGPT.nvim',
    config = {
      welcome_message = '',
      keymaps = {
        submit = "<C-s>",
      },
    },
    keys = {
      { '<leader>c', '<CMD>ChatGPT<CR>', desc = 'ChatGPT' },
    },
    dependencies = { 'https://github.com/MunifTanjim/nui.nvim' }
  },

  -- ChatGPT
  {
    'https://github.com/dpayne/CodeGPT.nvim',
    lazy = false,
    dependencies = {
      'https://github.com/MunifTanjim/nui.nvim',
      'https://github.com/nvim-lua/plenary.nvim',
    }
  },

  -- fixes indentation problems with bullet lists
  {
    'https://github.com/dkarter/bullets.vim',
    ft = 'markdown',
  },

  -- github integration
  {
    'https://github.com/pwntester/octo.nvim',
    cmd = 'Octo',
    config = true,
  },

  -- -- use vscode's container definitions in nvim
  -- { 'https://github.com/jamestthompson3/nvim-remote-containers' },

  -- translate text
  {
    'https://github.com/potamides/pantran.nvim',
    cmd = 'Pantran',
    config = {
      default_engine = 'deepl',
      engines = { deepl = { default_target = 'de' } },
    },
  },
}

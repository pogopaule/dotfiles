return {
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
}

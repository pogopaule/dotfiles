return {
  {
    'https://github.com/jackMort/ChatGPT.nvim',
    dependencies = { 'https://github.com/MunifTanjim/nui.nvim' },
    event = 'VeryLazy',
    config = {
      chat = {
        welcome_message = '',
      },
      actions_paths = { '~/dotfiles/nvim/chatgpt/actions.json' },
      openai_params = {
        model = "gpt-4-0125-preview",
      },
    },
    keys = {
      { '<leader>cc', '<cmd>ChatGPT<CR>',                              desc = 'ChatGPT' },
      { '<leader>ce', '<cmd>ChatGPTEditWithInstruction<CR>',           desc = 'Edit with instruction',     mode = { 'n', 'v' } },
      { '<leader>cg', '<cmd>ChatGPTRun grammar_correction<CR>',        desc = 'Grammar Correction',        mode = { 'n', 'v' } },
      { '<leader>ct', '<cmd>ChatGPTRun translate<CR>',                 desc = 'Translate',                 mode = { 'n', 'v' } },
      { '<leader>ck', '<cmd>ChatGPTRun keywords<CR>',                  desc = 'Keywords',                  mode = { 'n', 'v' } },
      { '<leader>cd', '<cmd>ChatGPTRun docstring<CR>',                 desc = 'Docstring',                 mode = { 'n', 'v' } },
      { '<leader>ca', '<cmd>ChatGPTRun add_tests<CR>',                 desc = 'Add Tests',                 mode = { 'n', 'v' } },
      { '<leader>co', '<cmd>ChatGPTRun optimize_code<CR>',             desc = 'Optimize Code',             mode = { 'n', 'v' } },
      { '<leader>cs', '<cmd>ChatGPTRun summarize<CR>',                 desc = 'Summarize',                 mode = { 'n', 'v' } },
      { '<leader>cf', '<cmd>ChatGPTRun fix_bugs<CR>',                  desc = 'Fix Bugs',                  mode = { 'n', 'v' } },
      { '<leader>cx', '<cmd>ChatGPTRun explain_code<CR>',              desc = 'Explain Code',              mode = { 'n', 'v' } },
      { '<leader>cl', '<cmd>ChatGPTRun code_readability_analysis<CR>', desc = 'Code Readability Analysis', mode = { 'n', 'v' } },
    },
  },
}

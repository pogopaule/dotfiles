return {
  {
    "https://github.com/epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "secondbrain",
          path = "~/secondbrain",
        },
      },
      templates = {
        subdir = "4 templates",
      },
      disable_frontmatter = true,
      note_id_func = function(title)
        return title
      end,
    },
    keys = {
      -- TODO: add whickkey group
      { '<leader>og', '<cmd>ObsidianSearch<CR>', desc = 'Grep' },
      { '<leader>fo', '<cmd>ObsidianQuickSwitch<CR>', desc = 'Find File' },
      { '<leader>oo', '<cmd>ObsidianOpen<CR>', desc = 'Open in Obsidian' },
      { '<leader>of', '<cmd>ObsidianFollowLink<CR>', desc = 'Follow Link' },
      { '<leader>ot', '<cmd>ObsidianTemplate<CR>', desc = 'Insert Template' },
    },
  },
  {
    'https://github.com/rest-nvim/rest.nvim',
    config = true,
  },
  {
    'https://github.com/ThePrimeagen/harpoon',
    event = 'VeryLazy',
    keys = {
      { '<leader>H',  '<CMD>lua require("harpoon.mark").add_file()<CR>', desc = 'Add File to Harpoon' },
      { '<leader>fH', '<CMD>Telescope harpoon marks<CR>',                desc = 'Find Harpoon File' },
      { '<leader>1',  '<CMD>:lua require("harpoon.ui").nav_file(1)<CR>', desc = 'Go to Harpoon File 1' },
      { '<leader>2',  '<CMD>:lua require("harpoon.ui").nav_file(2)<CR>', desc = 'Go to Harpoon File 2' },
      { '<leader>3',  '<CMD>:lua require("harpoon.ui").nav_file(3)<CR>', desc = 'Go to Harpoon File 3' },
    },
    config = true,
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
  -- ChatGPT
  {
    'https://github.com/jackMort/ChatGPT.nvim',
    dependencies = { 'https://github.com/MunifTanjim/nui.nvim' },
    event = 'VeryLazy',
    config = {
      chat = {
        welcome_message = '',
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

return {
  {
    'https://github.com/zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
      }
    },
  },
  {
    'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
    event = 'VeryLazy',
    branch = 'canary',
    opts = {
      debug = true,
    },
  },
}

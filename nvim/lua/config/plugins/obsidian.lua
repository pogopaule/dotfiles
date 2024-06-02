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
      { '<leader>og', '<cmd>ObsidianSearch<CR>',      desc = 'Grep' },
      { '<leader>fo', '<cmd>ObsidianQuickSwitch<CR>', desc = 'Find File' },
      { '<leader>oo', '<cmd>ObsidianOpen<CR>',        desc = 'Open in Obsidian' },
      { '<leader>of', '<cmd>ObsidianFollowLink<CR>',  desc = 'Follow Link' },
      { '<leader>ot', '<cmd>ObsidianTemplate<CR>',    desc = 'Insert Template' },
    },
  }
}

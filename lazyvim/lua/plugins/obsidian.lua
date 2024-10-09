return {
  {
    "epwalsh/obsidian.nvim",
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
      notes_subdir = "0 Inbox",
      mappings = {
        ["<cr>"] = { action = "<cmd>ObsidianFollowLink<CR>", opts = { buffer = true, desc = "Follow Obsidian Link" } },
      },
      new_notes_location = "notes_subdir",
    },
    cmd = {
      "ObsidianQuickSwitch",
    },
    keys = {
      { "<leader>o", "", desc = "+obsidian" },
      { "<leader>og", "<cmd>ObsidianSearch<CR>", desc = "Grep" },
      { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find File" },
      { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian" },
      { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Template" },
      { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
    },
  },
}

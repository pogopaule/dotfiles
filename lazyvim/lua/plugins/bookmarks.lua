return {
  {
    "tomasky/bookmarks.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>m", "", desc = "+bookmarks" },
      { "<leader>mm", '<CMD>lua require("bookmarks").bookmark_toggle()<CR>', desc = "Toggle Bookmark" },
      { "<leader>me", '<CMD>lua require("bookmarks").bookmark_ann()<CR>', desc = "Add Annotation" },
      { "<leader>mc", '<CMD>lua require("bookmarks").bookmark_clean()<CR>', desc = "Clean Bookmarks" },
      { "<leader>mn", '<CMD>lua require("bookmarks").bookmark_next()<CR>', desc = "Next Bookmark" },
      { "<leader>mp", '<CMD>lua require("bookmarks").bookmark_prev()<CR>', desc = "Previous Bookmark" },
      { "<leader>ml", '<CMD>lua require("telescope").extensions.bookmarks.list()<CR>', desc = "List Bookmarks" },
      { "<leader>mx", '<CMD>lua require("bookmarks").bookmark_clear_all()<CR>', desc = "Clear All Bookmarks" },
    },
    config = function()
      require("bookmarks").setup({
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand("$HOME/.bookmarks"), -- bookmarks save file path
        signs = {
          add = {
            text = "",
          },
          ann = {
            text = "",
          },
        },
      })
    end,
  },
}

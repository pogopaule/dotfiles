return {

  {
    "ruifm/gitlinker.nvim",
    keys = {
      { "<leader>gy", '<cmd>lua require("gitlinker").get_buf_range_url("n")<cr>', desc = "Github Link" },
    },
    config = true,
  },
}

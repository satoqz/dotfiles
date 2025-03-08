return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    event = "VeryLazy",
    keys = {
      { "<leader>gg", "<cmd>Git<cr>" },
      { "<leader>gw", "<cmd>GBrowse<cr><cr>" },
    },
  },
}

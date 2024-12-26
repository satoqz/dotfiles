return {
  "tpope/vim-sleuth",

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.surround").setup()
      require("mini.comment").setup()
    end,
  },

  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = { signs_staged_enable = false },
  },

  {
    "stevearc/oil.nvim",
    config = true,
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

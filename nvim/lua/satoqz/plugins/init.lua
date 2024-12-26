return {
  "tpope/vim-sleuth",
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
  },

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
    "stevearc/oil.nvim",
    config = true,
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

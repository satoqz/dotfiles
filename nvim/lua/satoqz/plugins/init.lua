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
      require("mini.comment").setup({
        mappings = {
          comment_line = "<C-c>",
          comment_visual = "<C-c>",
        },
      })

      require("mini.bufremove").setup()
      vim.keymap.set("n", "<leader>w", MiniBufremove.delete)
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

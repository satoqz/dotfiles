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

    end,
  },

  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
      vim.keymap.set("n", "<leader>g", "<cmd>Gedit :<CR>")
    end,
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

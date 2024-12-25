return {
  "tpope/vim-sleuth",

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.pairs").setup()
      require("mini.surround").setup()

      require("mini.comment").setup({
        mappings = {
          comment_line = "<C-c>",
          comment_visual = "<C-c>",
        },
      })

      require("mini.bufremove").setup()
      vim.keymap.set("n", "<leader>x", MiniBufremove.delete)
    end,
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

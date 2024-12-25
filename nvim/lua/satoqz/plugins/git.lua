return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
      vim.keymap.set("n", "<leader>g", "<cmd>vertical Git<CR>")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs_staged_enable = false,
    },
  },
}

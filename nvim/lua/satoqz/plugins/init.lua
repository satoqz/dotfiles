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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>h", function()
        harpoon:list():add()
      end)

      vim.keymap.set("n", "<leader>j", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
    end,
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

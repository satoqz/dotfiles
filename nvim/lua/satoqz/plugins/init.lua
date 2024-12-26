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
      vim.keymap.set("n", "<leader>x", MiniBufremove.delete)
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
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
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

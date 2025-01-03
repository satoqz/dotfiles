return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame_opts = { delay = 50 },
    },
    config = function(_, opts)
      local gitsigns = require("gitsigns")
      gitsigns.setup(opts)

      vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
      vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted)

      vim.keymap.set("n", "]g", function()
        gitsigns.nav_hunk("next")
      end)

      vim.keymap.set("n", "[g", function()
        gitsigns.nav_hunk("next")
      end)
    end,
  },

  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    init = function()
      vim.keymap.set("n", "<leader>gg", "<cmd>Git<CR>")
    end,
  },
}

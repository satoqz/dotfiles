return {
  "tpope/vim-sleuth",

  {
    "stevearc/oil.nvim",
    config = function()
      local oil = require("oil")

      oil.setup({
        view_options = { show_hidden = true },
        skip_confirm_for_simple_edits = true,
      })

      vim.keymap.set("n", "<leader>e", oil.open)
    end,
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

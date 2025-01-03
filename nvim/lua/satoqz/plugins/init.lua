return {
  "tpope/vim-sleuth",

  {
    "stevearc/oil.nvim",
    opts = {
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = true,
    },
    config = function(_, opts)
      local oil = require("oil")
      oil.setup(opts)
      vim.keymap.set("n", "<leader>e", oil.open)
    end,
  },

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

return {
  "tpope/vim-sleuth",

  {
    "stevearc/dressing.nvim",
    config = true,
  },

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
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_show_eob = 0
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}

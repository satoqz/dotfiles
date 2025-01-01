return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = { auto_install = true, highlight = { enable = true } },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local kanagawa = require("kanagawa")
      kanagawa.setup({
        compile = true,
        theme = "dragon",
        background = { dark = "dragon", light = "lotus" },
        colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      })
      kanagawa.load()
    end,
  },
}

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
    opts = {
      compile = true,
      theme = "dragon",
      background = { dark = "dragon", light = "lotus" },
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      overrides = function(colors)
        local ui = colors.theme.ui
        return {
          StatusLine = { bg = ui.bg_p1 },
          StatusLineNC = { bg = ui.bg_p1 },
          Pmenu = { fg = ui.shade0, bg = ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = ui.bg_p2 },
          PmenuSbar = { bg = ui.bg_m1 },
          PmenuThumb = { bg = ui.bg_p2 },
        }
      end,
    },
    config = function(_, opts)
      local kanagawa = require("kanagawa")
      kanagawa.setup(opts)
      kanagawa.load()
    end,
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = { auto_install = true, highlight = { enable = true } },
  },

  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        highlights = {
          -- Completely invisible by default.
          MiniTrailspace = { bg = "${red}" },
          -- Colors the entire foreground as well by default, this only undercurls it.
          DiagnosticUnderlineError = { sp = "${red}", undercurl = true },
          DiagnosticUnderlineWarn = { sp = "${yellow}", undercurl = true },
          DiagnosticUnderlineInfo = { sp = "${blue}", undercurl = true },
          DiagnosticUnderlineHint = { sp = "${cyan}", undercurl = true },
        },
      })

      vim.cmd.colorscheme("onedark")
    end,
  },

  {
    "sainnhe/gruvbox-material",
    event = "VeryLazy",
  },

  {
    "sainnhe/sonokai",
    event = "VeryLazy",
  },

  {
    "Mofiqul/vscode.nvim",
    event = "VeryLazy",
  },

  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VeryLazy",
  },
}

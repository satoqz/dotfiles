return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = { auto_install = true, highlight = { enable = true } },
  },

  {
    "sainnhe/gruvbox-material",
    event = "VeryLazy",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox-material")
    end,
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

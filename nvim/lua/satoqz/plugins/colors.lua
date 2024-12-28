return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = { auto_install = true },
  },

  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        highlights = {
          NeoTreeDirectoryIcon = { fg = "${blue}" },
          NeoTreeRootName = { fg = "${blue}" },
        },
      })
      vim.cmd.colorscheme("onedark")
    end,
  },
}

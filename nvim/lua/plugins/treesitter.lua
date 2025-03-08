return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    lazy = vim.fn.argc(-1) == 0,
    main = "nvim-treesitter.configs",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      auto_install = vim.fn.executable("cc"),
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]c"] = "@class.outer",
            ["]f"] = "@function.outer",
          },
          goto_previous_start = {
            ["[c"] = "@class.outer",
            ["[f"] = "@function.outer",
          },
          goto_next_end = {
            ["]C"] = "@class.outer",
            ["]F"] = "@function.outer",
          },
          goto_previous_end = {
            ["[C"] = "@class.outer",
            ["[F"] = "@function.outer",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          include_surounding_whitespace = true,
          keymaps = {
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
  },
  {
    "VidocqH/auto-indent.nvim",
    event = "InsertEnter",
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = true,
  },
  {
    "davidmh/mdx.nvim",
    ft = "mdx",
    config = true,
  },
}

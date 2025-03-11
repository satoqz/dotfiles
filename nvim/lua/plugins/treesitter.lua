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
            ["]s"] = "@class.outer",
            ["]f"] = "@function.outer",
          },
          goto_previous_start = {
            ["[s"] = "@class.outer",
            ["[f"] = "@function.outer",
          },
          goto_next_end = {
            ["]S"] = "@class.outer",
            ["]F"] = "@function.outer",
          },
          goto_previous_end = {
            ["[S"] = "@class.outer",
            ["[F"] = "@function.outer",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          include_surounding_whitespace = true,
          keymaps = {
            ["as"] = "@class.outer",
            ["is"] = "@class.inner",
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
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      multiwindow = true,
      multiline_threshold = 1,
    },
    keys = {
      { "[c", function() require("treesitter-context").go_to_context(vim.v.count1) end },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("satoqz-treesitter-context-highlights", { clear = true }),
        callback = function()
          vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
          vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
        end,
      })
    end,
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

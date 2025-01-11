return {
  "tpope/vim-sleuth",

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.trailspace").setup()
      require("mini.comment").setup({
        mappings = {
          comment_line = "<C-c>",
          comment_visual = "<C-c>",
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = { auto_install = true, highlight = { enable = true } },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "frappe" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = require("telescope.themes").get_ivy({
          file_ignore_patterns = { "%.git/", "%.venv/" },
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          mappings = {
            i = { ["<esc>"] = require("telescope.actions").close },
          },
        }),
      })

      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")

      vim.keymap.set("n", "<leader>'", builtin.resume)
      vim.keymap.set("n", "<leader>b", function()
        builtin.buffers({ sort_mru = true })
      end)
      vim.keymap.set("n", "<leader>/", function()
        builtin.grep_string({ search = vim.fn.input("grep: ") })
      end)
      vim.keymap.set("n", "<leader>f", function()
        builtin.find_files({ hidden = true })
      end)
      vim.keymap.set("n", "<leader>.", function()
        builtin.find_files({ hidden = true, cwd = utils.buffer_dir() })
      end)
    end,
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
    "stevearc/conform.nvim",
    event = "BufWritePre",
    command = "ConformInfo",
    opts = {
      format_on_save = { timeout_ms = 1000 },
      formatters_by_ft = {
        fish = { "fish_indent" },
        lua = { "stylua" },
      },
    },
  },

  {
    "stevearc/dressing.nvim",
    config = true,
  },
}

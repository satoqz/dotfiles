return {
  "tpope/vim-sleuth",

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.surround").setup()
      require("mini.starter").setup({ footer = "", silent = true })
      require("mini.comment").setup({
        mappings = {
          comment_line = "<C-c>",
          comment_visual = "<C-c>",
        },
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_diagnostics = false,
        enable_git_status = false,
        filesystem = {
          filtered_items = { hide_dotfiles = false },
          follow_current_file = { enabled = true, leave_dirs_open = true },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree<CR>")
      vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle<CR>")
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = false,
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },

  {
    "laytan/cloak.nvim",
    config = true,
  },
}

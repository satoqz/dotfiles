return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = true,
    },
    config = function(_, opts)
      local oil = require("oil")
      oil.setup(opts)
      vim.keymap.set("n", "<leader>o", oil.open, { desc = "Oil" })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
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
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree<CR>", { desc = "Neotree: Focus" })
      vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle<CR>", { desc = "Neotree: Toggle" })
    end,
  },
}

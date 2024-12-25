return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = false,
        enable_diagnostics = false,
        filesystem = {
          filtered_items = { hide_dotfiles = false, hide_gitignored = false },
          follow_current_file = { enabled = true, leave_dirs_open = true },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
    end,
  },
}

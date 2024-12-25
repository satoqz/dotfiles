return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = { horizontal = { prompt_position = "top" } },
          mappings = { i = { ["<esc>"] = actions.close } },
        },
      })

      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")

      vim.keymap.set("n", "<leader>/", function()
        builtin.grep_string({ search = vim.fn.input("grep: ") })
      end)

      vim.keymap.set("n", "<leader>b", builtin.buffers)

      vim.keymap.set("n", "<leader>f", builtin.git_files)
      vim.keymap.set("n", "<leader>F", builtin.find_files)
      vim.keymap.set("n", "<leader>.", function()
        builtin.find_files({ cwd = utils.buffer_dir() })
      end)

      vim.keymap.set("n", "<leader>d", builtin.diagnostics)
      vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols)
      vim.keymap.set("n", "<leader>S", builtin.lsp_workspace_symbols)

      vim.keymap.set("n", "gd", builtin.lsp_definitions)
      vim.keymap.set("n", "gt", builtin.lsp_type_definitions)
      vim.keymap.set("n", "gi", builtin.lsp_implementations)
    end,
  },
}

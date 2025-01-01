return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      defaults = require("telescope.themes").get_ivy({
        file_ignore_patterns = { "%.git/", "%.venv/" },
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        layout_config = { height = 0.7 },
        mappings = {
          i = { ["<esc>"] = require("telescope.actions").close },
        },
      }),
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")

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

      vim.keymap.set("n", "<leader>th", function()
        builtin.colorscheme({ enable_preview = true })
      end)

      vim.keymap.set("n", "<leader>gs", builtin.git_status)
      vim.keymap.set("n", "<leader>gS", builtin.git_stash)
      vim.keymap.set("n", "<leader>gc", builtin.git_commits)
      vim.keymap.set("n", "<leader>gb", builtin.git_branches)

      vim.keymap.set("n", "<leader>s", function()
        builtin.lsp_document_symbols({
          symbols = {
            "Class",
            "Constant",
            "Constructor",
            "Enum",
            "Function",
            "Interface",
            "Method",
            "Struct",
          },
        })
      end)

      vim.keymap.set("n", "gd", builtin.lsp_definitions)
      vim.keymap.set("n", "gy", builtin.lsp_type_definitions)
      vim.keymap.set("n", "gi", builtin.lsp_implementations)
      vim.keymap.set("n", "gr", builtin.lsp_references)
    end,
  },
}

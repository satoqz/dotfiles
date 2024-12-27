return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = require("telescope.themes").get_ivy({
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          layout_config = { height = 0.7 },
          mappings = {
            i = { ["<esc>"] = actions.close },
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

      local lsp_symbols = vim.tbl_map(string.lower, vim.lsp.protocol.SymbolKind)
      local symbols = vim.tbl_filter(function(symbol)
        return symbol ~= "field" and symbol ~= "module"
      end, lsp_symbols)

      vim.keymap.set("n", "<leader>s", function()
        builtin.lsp_document_symbols({ symbols = symbols })
      end)

      vim.keymap.set("n", "gd", builtin.lsp_definitions)
      vim.keymap.set("n", "gy", builtin.lsp_type_definitions)
      vim.keymap.set("n", "gi", builtin.lsp_implementations)
      vim.keymap.set("n", "gr", builtin.lsp_references)
    end,
  },
}

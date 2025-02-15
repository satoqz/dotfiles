return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "%.git/", "%.venv/" },
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          prompt_prefix = " ",
          selection_caret = "  ",
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
              ["<C-c>"] = function()
                vim.cmd.stopinsert()
              end,
            },
          },
        },
      })

      telescope.load_extension("fzf")

      local map = function(keys, func, desc, mode)
        vim.keymap.set(mode or "n", keys, func, { desc = "Telescope: " .. desc })
      end

      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")

      map("<leader>f", function()
        builtin.find_files({ hidden = true })
      end, "[F]iles (workspace)")
      map("<leader>F", function()
        builtin.find_files({ hidden = true, cwd = utils.buffer_dir() })
      end, "[F]iles (buffer's directory)")

      map("<leader>b", function()
        builtin.buffers({ sort_mru = true })
      end, "[B]uffers")

      map("<leader>th", function()
        builtin.colorscheme({ enable_preview = true })
      end, "[Th]eme")

      map("<leader>/", builtin.live_grep, "Live Grep")
      map("<leader>gs", builtin.git_status, "[G]it [S]tatus")
      map("<leader>gc", builtin.git_commits, "[G]it [C]ommits")
      map("<leader>gb", builtin.git_branches, "[G]it [B]ranches")
      map("<leader>'", builtin.resume, "Resume")
    end,
  },
}

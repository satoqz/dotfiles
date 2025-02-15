local map = function(keys, func, desc, mode)
  vim.keymap.set(mode or "n", keys, func, { desc = "Git: " .. desc })
end

return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame_opts = { delay = 50 },
    },
    config = function(_, opts)
      local gitsigns = require("gitsigns")
      gitsigns.setup(opts)

      map("<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle [B]lame")
      map("<leader>td", gitsigns.preview_hunk_inline, "[T]oggle [D]iff")

      map("]g", function()
        gitsigns.nav_hunk("next")
      end, "Next hunk")

      map("[g", function()
        gitsigns.nav_hunk("prev")
      end, "Previous hunk")
    end,
  },
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    init = function()
      map("<leader>gg", "<cmd>Git<CR>", "Fugitive UI")
    end,
  },
}

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "Gitsigns" },
  opts = {
    current_line_blame_opts = {
      delay = 50,
    },
    on_attach = function(buffer)
      local function map(keys, func, mode) vim.keymap.set(mode or "n", keys, func, { buffer = buffer }) end

      local gitsigns = require("gitsigns")

      map("[g", function() gitsigns.nav_hunk("prev") end)
      map("]g", function() gitsigns.nav_hunk("next") end)
      map("[G", function() gitsigns.nav_hunk("first") end)
      map("]G", function() gitsigns.nav_hunk("last") end)

      map("<leader>tb", gitsigns.toggle_current_line_blame)
      map("<leader>hi", gitsigns.preview_hunk_inline)

      map("ih", ":<c-u>Gitsigns select_hunk<cr>", { "o", "x" })
    end,
  },
}

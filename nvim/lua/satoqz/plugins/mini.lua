return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.jump").setup()
      require("mini.surround").setup()
      require("mini.operators").setup()
      require("mini.trailspace").setup()

      require("mini.pairs").setup({
        mappings = {
          -- Fixes Rust lifetimes such as &'a.
          ["'"] = { neigh_pattern = "[^(%a|&)\\]." },
        },
      })

      require("mini.comment").setup({
        mappings = {
          comment_line = "<C-c>",
          comment_visual = "<C-c>",
        },
      })

      local misc = require("mini.misc")
      misc.setup_restore_cursor()
      misc.setup_termbg_sync()
    end,
  },
}

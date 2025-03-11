return {
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    keys = {
      { "<leader>q", function() require("quicker").toggle() end },
    },
    opts = {
      keys = {
        { ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end },
        { "<", function() require("quicker").collapse() end },
      },
    },
  },
}

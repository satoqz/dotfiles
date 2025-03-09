return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        format = {
          cmdline = { icon = ":", title = "" },
          search_down = { icon = "/", title = "" },
          search_up = { icon = "?", title = "" },
          filter = { icon = "!", title = "" },
          lua = { icon = "lua", title = "" },
          input = { icon = "" },
          help = false,
        },
      },
      messages = {
        -- view_search = "mini",
      },
      lsp = {
        progress = { enabled = false },
        signature = { enabled = false },
        hover = { silent = true },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "written$" },
              { find = "^E486" },
              { find = "^/" },
              { find = "^?" },
            },
          },
          opts = { skip = true },
        },
      },
    },
    keys = {
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        mode = { "n", "i", "s" },
        silent = true,
        expr = true,
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        mode = { "n", "i", "s" },
        silent = true,
        expr = true,
      },
    },
  },
}

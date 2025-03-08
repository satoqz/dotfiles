return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "xzbdmw/colorful-menu.nvim", config = true },
    },
    config = function()
      require("blink.cmp").setup({
        keymap = { preset = "super-tab" },
        cmdline = { enabled = false },
        signature = { enabled = true },
        completion = {
          documentation = { auto_show = true },
          menu = {
            draw = {
              treesitter = { "lsp" },
              columns = { { "label" } },
              components = {
                label = {
                  text = require("colorful-menu").blink_components_text,
                  highlight = require("colorful-menu").blink_components_highlight,
                },
              },
            },
          },
        },
        sources = {
          default = { "lazydev", "lsp" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
      })
    end,
  },
}

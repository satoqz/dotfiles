return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", config = true },
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")

      local servers = {
        rust_analyzer = {},
        gopls = {},
        zls = {},
        terraformls = {},
      }

      vim.g.zig_fmt_parse_errors = 0
      vim.g.zig_fmt_autosave = 0

      for server, config in pairs(servers) do
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "super-tab" },
      sources = { default = { "lsp", "path" }, cmdline = {} },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    command = "ConformInfo",
    opts = {
      default_format_opts = { lsp_format = "fallback" },
      format_on_save = { timeout_ms = 1000 },
      formatters_by_ft = { lua = { "stylua" } },
    },
  },
}

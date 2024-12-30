return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", config = true },
      "saghen/blink.cmp",
    },
    config = function()
      local util = require("satoqz.util")
      for _, server in ipairs({
        "clangd",
        "gopls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "terraformls",
        "zls",
      }) do
        util.setup_language_server(server)
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    command = "ConformInfo",
    opts = {
      default_format_opts = { lsp_format = "fallback" },
      format_on_save = { timeout_ms = 1000 },
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        lua = { "stylua" },
        python = { "ruff_format" },
      },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "super-tab" },
      appearance = { use_nvim_cmp_as_default = true },
      signature = { enabled = true },
      completion = {
        documentation = { auto_show = true },
        menu = {
          draw = {
            columns = { { "kind" }, { "label", "label_description", gap = 1 } },
          },
        },
      },
      sources = {
        cmdline = {},
        default = { "lazydev", "lsp", "path" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}

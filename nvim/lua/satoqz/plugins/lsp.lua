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
        gopls = {},
        lua_ls = {},
        rust_analyzer = {},
        terraformls = {},
        ts_ls = {},
        zls = {},
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

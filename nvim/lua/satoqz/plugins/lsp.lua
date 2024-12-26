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

      local function enable_inlay_hints(_, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      local servers = {
        rust_analyzer = {
          on_attach = enable_inlay_hints,
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                parameterHints = { enable = false },
                genericParameterHints = { const = { enable = false } },
              },
            },
          },
        },
        gopls = {},
        zls = {},
        terraformls = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
      vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action)
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path" }, cmdline = {} },
      keymap = { preset = "super-tab" },
    },
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = { hint_enable = false },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    command = "ConformInfo",
    config = function()
      local conform = require("conform")

      conform.setup({
        default_format_opts = { lsp_format = "fallback" },
        format_on_save = { timeout_ms = 1000 },
        formatters_by_ft = { lua = { "stylua" } },
      })

      vim.keymap.set("n", "<leader>c", function()
        conform.format({ async = true })
      end)
    end,
  },
}

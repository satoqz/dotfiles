return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      appearance = { use_nvim_cmp_as_default = true },
      signature = { enabled = true },
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path" }, cmdline = {} },
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "j-hui/fidget.nvim",
        opts = { notification = { window = { winblend = 0 } } },
      },
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
        gopls = {
          on_attach = enable_inlay_hints,
        },
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
    "stevearc/conform.nvim",
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

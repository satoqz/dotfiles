return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", config = true },
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("satoqz-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local telescope = require("telescope.builtin")

          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gd", telescope.lsp_definitions, "[G]oto [D]efinitions")
          map("gy", telescope.lsp_type_definitions, "[G]oto T[y]pe Definitions")
          map("gi", telescope.lsp_implementations, "[G]oto [I]mplementations")
          map("gr", telescope.lsp_references, "[G]oto [R]eferences")

          map("<leader>r", vim.lsp.buf.rename, "[R]ename")
          map("<leader>a", vim.lsp.buf.code_action, "Code [A]ction")

          map("<leader>s", telescope.lsp_document_symbols, "Document [S]ymbols")
          map("<leader>S", telescope.lsp_dynamic_workspace_symbols, "Workspace [S]ymbols")

          map("<leader>d", function()
            telescope.diagnostics({ bufnr = 1 })
          end, "Buffer [D]iagnostics")
          map("<leader>D", telescope.diagnostics, "Workspace [D]iagnostics")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>ti", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle [I]nlay Hints")
          end
        end,
      })

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

      vim.diagnostic.config({ signs = false })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    command = { "ConformInfo", "FormatDisable", "FormatEnable" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          fish = { "fish_indent" },
          go = { "goimports", "gofmt" },
          lua = { "stylua" },
          python = { "ruff_format" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 1000, lsp_format = "fallback" }
        end,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function(args)
        if args.bang then
          vim.b.disable_autoformat = false
        else
          vim.g.disable_autoformat = false
        end
      end, {
        desc = "Re-enable autoformat-on-save",
        bang = true,
      })
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
      appearance = { use_nvim_cmp_as_default = true },
      keymap = { preset = "super-tab" },
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

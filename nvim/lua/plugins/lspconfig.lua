return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart", "LspLog", "LspSetup" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("satoqz-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf })
          end

          map("gd", Snacks.picker.lsp_definitions)
          map("gD", Snacks.picker.lsp_declarations)
          map("gy", Snacks.picker.lsp_type_definitions)
          map("gi", Snacks.picker.lsp_implementations)
          map("gr", Snacks.picker.lsp_references)

          map("crn", vim.lsp.buf.rename)
          map("crr", vim.lsp.buf.code_action)

          map("<leader>s", Snacks.picker.lsp_symbols)
          map("<leader>S", Snacks.picker.lsp_workspace_symbols)

          map("<leader>p", Snacks.picker.diagnostics_buffer)
          map("<leader>P", Snacks.picker.diagnostics)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map(
              "<leader>ti",
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
              end
            )
          end
        end,
      })

      vim.api.nvim_create_autocmd("LspProgress", {
        group = vim.api.nvim_create_augroup("satoqz-lsp-progress", { clear = true }),
        callback = function(ev)
          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(vim.lsp.status(), "info", {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
              notif.icon = ev.data.params.value.kind == "end" and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })

      local util = require("config.util")

      vim.api.nvim_create_user_command("LspSetup", function(args)
        util.setup_language_server(args.args, {}, {}, true)
        vim.cmd("doautocmd FileType " .. vim.bo.filetype)
      end, { nargs = 1, complete = util.complete_language_server })

      for _, server in ipairs({
        "clangd",
        "gopls",
        "lua_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "zls",
      }) do
        util.setup_language_server(server)
      end
    end,
  },
}

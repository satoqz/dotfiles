return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart", "LspLog", "LspSetup" },
    keys = {
      { "<leader>a", vim.lsp.buf.code_action },
      { "<leader>i", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end },
      { "<leader>r", vim.lsp.buf.rename },
      { "gA", function() Snacks.picker.lsp_workspace_symbols() end },
      { "gD", function() Snacks.picker.lsp_declarations() end },
      { "gP", function() Snacks.picker.diagnostics() end },
      { "ga", function() Snacks.picker.lsp_symbols() end },
      { "gd", function() Snacks.picker.lsp_definitions() end },
      { "gi", function() Snacks.picker.lsp_implementations() end },
      { "gp", function() Snacks.picker.diagnostics_buffer() end },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true },
      { "gy", function() Snacks.picker.lsp_type_definitions() end },
    },
    config = function()
      vim.diagnostic.config({ signs = false })

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

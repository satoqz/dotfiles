return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo", "Format", "FormatWith", "FormatEnable", "FormatDisable" },
  opts = {
    formatters_by_ft = { lua = { "stylua" } },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)

    vim.api.nvim_create_user_command("Format", conform.format, {})

    vim.api.nvim_create_user_command("FormatWith", function(args)
      conform.formatters_by_ft[vim.bo.ft] = args.fargs
      conform.format()
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function(args)
      if args.bang then
        vim.b.disable_autoformat = false
      else
        vim.g.disable_autoformat = false
      end
    end, { bang = true })
  end,
}

local M = {}

M.setup_language_server = function(server_name, settings, config)
  local default_config = require("lspconfig.configs." .. server_name).default_config
  if vim.fn.executable(default_config.cmd[1]) == 0 then
    return
  end

  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")

  config = config or {}
  config.settings = settings or {}
  config.capabilities = blink.get_lsp_capabilities(config.capabilities)
  lspconfig[server_name].setup(config)
end

M.set_formatters = function(filetype, formatters)
  require("conform").formattters_by_ft[filetype] = formatters
end

return M

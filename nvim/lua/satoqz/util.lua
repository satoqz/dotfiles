local M = {}

M.setup_language_server = function(server_name, settings, config)
  local default_config = require("lspconfig.configs." .. server_name).default_config
  config = config or {}

  if vim.fn.executable((config.cmd or default_config.cmd)[1]) == 0 then
    return
  end

  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")

  config.settings = settings or {}
  config.capabilities = blink.get_lsp_capabilities(config.capabilities)
  lspconfig[server_name].setup(config)
end

return M

local M = {}

local function list_language_servers()
  local path = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig/lua/lspconfig/configs"
  local servers = {}
  for _, file in ipairs(vim.fn.readdir(path)) do
    local server = vim.fn.trim(file, ".lua", 2)
    table.insert(servers, server)
  end
  return servers
end

M.language_servers = list_language_servers()

M.complete_language_server = function(input)
  return vim.tbl_filter(function(server) return string.match(server, input) end, M.language_servers)
end

M.setup_language_server = function(server_name, settings, config, verbose)
  if not vim.tbl_contains(M.language_servers, server_name) then
    if verbose then
      vim.notify(
        "Can't set up language server!\n`" .. server_name .. "` is not a valid language server.",
        vim.log.levels.ERROR
      )
    end
    return
  end

  local default_config = require("lspconfig.configs." .. server_name).default_config
  config = config or {}

  local executable = (config.cmd or default_config.cmd)[1]
  if vim.fn.executable(executable) == 0 then
    if verbose then
      vim.notify(
        "Can't set up language server!\n`" .. executable .. "` is not executable.",
        vim.log.levels.ERROR
      )
    end
    return
  end

  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")

  config.settings = settings or {}
  config.capabilities = blink.get_lsp_capabilities(config.capabilities)
  lspconfig[server_name].setup(config)
end

return M

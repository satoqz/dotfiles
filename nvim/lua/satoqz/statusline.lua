local function statusline_colorize(fg, suffix, component)
  local statusline_type = vim.api.nvim_get_current_win() == vim.g.statusline_winid and "" or "Nc"
  local highlight_name = "Statusline" .. statusline_type .. suffix

  vim.api.nvim_set_hl(0, highlight_name, {
    fg = fg,
    bg = vim.api.nvim_get_hl(0, { name = "Statusline" .. statusline_type }).bg,
  })

  return "%#" .. highlight_name .. "#" .. component .. "%*"
end

local function path_component(bufnr)
  if vim.bo[bufnr].buftype == "" then
    local buf_name = vim.api.nvim_buf_get_name(bufnr)
    if buf_name == "" then
      return "[No Name]"
    else
      return vim.fn.fnamemodify(buf_name, ":~:.")
    end
  else
    return "%f"
  end
end

local severity_to_highlight_suffix = {
  [vim.diagnostic.severity.ERROR] = "Error",
  [vim.diagnostic.severity.WARN] = "Warn",
}

local function diagnostics_component(bufnr, severity)
  local highlight_suffix = severity_to_highlight_suffix[severity]

  local diagnostics = vim.tbl_filter(function(diagnostic)
    return diagnostic.severity == severity
  end, vim.diagnostic.get(bufnr))

  if #diagnostics == 0 then
    return ""
  end

  return statusline_colorize(
    vim.api.nvim_get_hl(0, { name = "Diagnostic" .. highlight_suffix }).fg,
    highlight_suffix,
    " ■ " .. #diagnostics
  )
end

local M = {}

M.format = function()
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)

  local modified_component = vim.bo[bufnr].modified and " [+]" or ""
  local readonly_component = vim.bo[bufnr].readonly and " [readonly]" or ""

  return path_component(bufnr)
    .. modified_component
    .. readonly_component
    .. diagnostics_component(bufnr, vim.diagnostic.severity.ERROR)
    .. diagnostics_component(bufnr, vim.diagnostic.severity.WARN)
    .. "%=%l:%c "
end

return M
local function path_component(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  if bufname == "" then
    return "[No Name]"
  end

  if vim.startswith(bufname, "fugitive://") then
    return "fugitive: "
      .. vim.fn.fnamemodify(bufname:gsub("^fugitive://", ""):gsub("//$", ""), ":~")
  end

  if vim.startswith(bufname, "oil://") then
    return vim.fn.fnamemodify(bufname:gsub("^oil://", ""):gsub("/$", ""), ":~")
  end

  if vim.bo[bufnr].buftype == "" then
    return vim.fn.fnamemodify(bufname, ":~:.")
  end

  return "%f"
end

local M = {}

return function()
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)

  local modified_component = vim.bo[bufnr].modified and " [+]" or ""
  local readonly_component = vim.bo[bufnr].readonly and " [readonly]" or ""

  return path_component(bufnr) .. modified_component .. readonly_component .. "%=%l:%c "
end

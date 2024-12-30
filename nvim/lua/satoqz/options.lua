vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.autoindent = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true
vim.opt.exrc = true

vim.lsp.inlay_hint.enable(true)
vim.diagnostic.config({ signs = false })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd.checktime()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.wo.colorcolumn = "50,72"
  end,
})

function StatusLine()
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)

  local path_component = "%f"
  if vim.bo[bufnr].buftype == "" then
    local buf_name = vim.api.nvim_buf_get_name(bufnr)
    if buf_name == "" then
      path_component = "[No Name]"
    else
      path_component = vim.fn.fnamemodify(buf_name, ":~:.")
    end
  end

  local modified_component = vim.bo[bufnr].modified and " [+]" or ""
  local readonly_component = vim.bo[bufnr].readonly and " [readonly]" or ""

  local statusline_type = vim.api.nvim_get_current_win() == vim.g.statusline_winid and "" or "Nc"

  for _, kind in pairs({ "Error", "Warn" }) do
    vim.api.nvim_set_hl(0, "Statusline" .. kind .. statusline_type, {
      fg = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. kind }).fg,
      bg = vim.api.nvim_get_hl(0, { name = "Statusline" .. statusline_type }).bg,
    })
  end

  local function colorize(color, component)
    return "%#" .. color .. "#" .. component .. "%*"
  end

  local diagnostics = vim.diagnostic.get(bufnr)

  local errors = vim.tbl_filter(function(diagnostic)
    return diagnostic.severity == vim.diagnostic.severity.ERROR
  end, diagnostics)
  local warnings = vim.tbl_filter(function(diagnostic)
    return diagnostic.severity == vim.diagnostic.severity.WARN
  end, diagnostics)

  local error_component = #errors > 0
      and colorize("StatuslineError" .. statusline_type, " ~" .. #errors)
    or ""
  local warning_component = #warnings > 0
      and colorize("StatuslineWarn" .. statusline_type, " ~" .. #warnings)
    or ""
  local diagnostics_component = error_component .. warning_component

  return path_component
    .. modified_component
    .. readonly_component
    .. diagnostics_component
    .. "%=%l:%c "
end

vim.opt.statusline = "%!v:lua.StatusLine()"

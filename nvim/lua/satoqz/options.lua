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

-- https://www.reddit.com/r/neovim/comments/1dfhv97/how_to_get_relative_path_in_statusline/
function StatusLine()
  local rest = " %m %r %w%=%y %l:%c "
  if vim.fn.expand("%:~:.") == "" or vim.bo.buftype ~= "" then
    return "%t" .. rest
  end
  return vim.fn.expand("%:~:.") .. rest
end

vim.opt.statusline = "%!v:lua.StatusLine()"

vim.lsp.inlay_hint.enable(true)
vim.diagnostic.config({ signs = false })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd.checktime()
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.wo.colorcolumn = "50,72"
  end,
})

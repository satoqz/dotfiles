vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.opt.number = true
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
vim.opt.autoread = true

vim.diagnostic.config({ signs = false })

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd.checktime()
  end,
})

local git_commit_group = vim.api.nvim_create_augroup("GitCommitGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = git_commit_group,
  pattern = "gitcommit",
  callback = function()
    vim.wo.colorcolumn = "50,72"
  end,
})

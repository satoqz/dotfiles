vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.exrc = true

vim.opt.ruler = false
vim.opt.showtabline = 0
vim.opt.statusline = "%!v:lua.require('satoqz.statusline').format()"

vim.g.mapleader = " "

vim.keymap.set("n", "gn", "<cmd>bnext<CR>", { desc = "Buffer: [G]oto [N]ext" })
vim.keymap.set("n", "gp", "<cmd>bprev<CR>", { desc = "Buffer: [G]oto [P]revious" })

vim.keymap.set({ "n", "v" }, "-", '"_')
vim.keymap.set({ "n", "v" }, "+", '"+')

vim.keymap.set("n", "<Esc>", ':let @/ = ""<CR>', { silent = true })

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("satoqz-balance-windows", { clear = true }),
  callback = function()
    vim.cmd.wincmd("=")
  end,
})

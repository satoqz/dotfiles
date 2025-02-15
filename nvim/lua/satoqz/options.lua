vim.g.default_colorscheme = "sonokai"

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

vim.opt.clipboard = "unnamedplus"

vim.opt.ruler = false
vim.opt.showtabline = 0
vim.opt.statusline = "%!v:lua.require('satoqz.statusline').format()"

vim.g.mapleader = " "

vim.keymap.set("n", "gn", "<cmd>bnext<CR>", { desc = "Buffer: [G]oto [N]ext" })
vim.keymap.set("n", "gp", "<cmd>bprev<CR>", { desc = "Buffer: [G]oto [P]revious" })

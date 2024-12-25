vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "gn", "<cmd>bnext<CR>")
vim.keymap.set("n", "gp", "<cmd>bprevious<CR>")

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")

vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float)

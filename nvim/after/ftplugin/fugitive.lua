local base = "<cmd>Git commit --quiet"
local signoff = vim.g.signoff and " --signoff" or ""
local opts = { silent = true, noremap = true, buffer = 0 }

vim.keymap.set("n", "cc", base .. signoff .. "<cr>", opts)
vim.keymap.set("n", "ca", base .. " --amend" .. signoff .. "<cr>", opts)
vim.keymap.set("n", "ce", base .. " --amend --no-edit" .. signoff .. "<cr>", opts)

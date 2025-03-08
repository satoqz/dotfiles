vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("satoqz-balance-windows", { clear = true }),
  callback = function() vim.cmd.wincmd("=") end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("satoqz-highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

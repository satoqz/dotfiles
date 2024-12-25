return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
      vim.keymap.set("n", "<leader>g", "<cmd>Git<CR>")

      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = vim.api.nvim_create_augroup("FugitiveGroup", {}),
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end

          local opts = { buffer = vim.api.nvim_get_current_buf() }
          vim.keymap.set("n", "<leader>p", "<cmd>Git push<CR>", opts)
          vim.keymap.set("n", "<leader>t", "<cmd>Git push -u origin ", opts)
          vim.keymap.set("n", "<leader>P", "<cmd>Git pull --rebase<CR>", opts)
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs_staged_enable = false,
    },
  },
}

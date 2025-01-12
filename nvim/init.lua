vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 0
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.wrap = false

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.wo.colorcolumn = "50,72"
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local spec = {
  "tpope/vim-sleuth",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = vim.fn.executable("cc"),
      highlight = { enable = true },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "frappe" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

require("lazy").setup(spec, {
  change_detection = { notify = false },
  install = { colorscheme = { "catppuccin" } },
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd("checktime")
  end,
})

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
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

require("lazy").setup({
  "tpope/vim-sleuth",
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
    end,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      appearance = { use_nvim_cmp_as_default = true },
      signature = { enabled = true },
      sources = { default = { "lsp", "path" } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = { window = { winblend = 0 } },
        },
      },
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")

      local servers = {
        rust_analyzer = {
          on_attach = function(client, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
        },
        gopls = {},
        terraformls = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = blink.get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("init.lua-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf })
          end

          local builtin = require("telescope.builtin")

          map("gd", builtin.lsp_definitions)
          map("gD", vim.lsp.buf.declaration)
          map("gt", builtin.lsp_type_definitions)
          map("gi", builtin.lsp_implementations)
          map("<leader>a", vim.lsp.buf.code_action, { "n", "x" })
          map("<leader>d", builtin.diagnostics)
          map("<leader>r", vim.lsp.buf.rename)
          map("<leader>s", builtin.lsp_document_symbols)
          map("<leader>S", builtin.lsp_workspace_symbols)
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      conform.setup({
        default_format_opts = { lsp_format = "fallback" },
        format_on_save = { timeout_ms = 1000 },
        formatters_by_ft = {
          lua = { "stylua" },
        },
      })

      vim.keymap.set("n", "<leader>m", function()
        conform.format({ async = true })
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = { auto_install = true },
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = { horizontal = { prompt_position = "top" } },
          mappings = { i = { ["<esc>"] = actions.close } },
        },
      })

      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")

      vim.keymap.set("n", "<leader>/", function()
        builtin.grep_string({ search = vim.fn.input("grep: ") })
      end)

      vim.keymap.set("n", "<leader>b", builtin.buffers)

      vim.keymap.set("n", "<leader>f", builtin.git_files)
      vim.keymap.set("n", "<leader>F", builtin.find_files)

      vim.keymap.set("n", "<leader>.", function()
        builtin.find_files({ cwd = utils.buffer_dir() })
      end)
    end,
  },
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
      vim.keymap.set("n", "<leader>g", "<cmd>vertical Git<CR>")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = false,
        enable_diagnostics = false,
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
    end,
  },
}, {
  install = {
    colorscheme = { "gruvbox-material" },
  },
})

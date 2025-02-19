return {
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
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_show_eob = 0
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = true,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = true,
    },
    config = function(_, opts)
      local oil = require("oil")
      oil.setup(opts)
      vim.keymap.set("n", "<leader>e", oil.open, { desc = "[E]xplorer (Oil)" })
    end,
  },
  {
    "stevearc/dressing.nvim",
    config = true,
  },
  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame_opts = { delay = 50 },
    },
    config = function(_, opts)
      local gitsigns = require("gitsigns")
      gitsigns.setup(opts)

      local map = function(keys, func, desc, mode)
        vim.keymap.set(mode or "n", keys, func, { desc = "Git: " .. desc })
      end

      map("<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle [B]lame")
      map("<leader>hi", gitsigns.preview_hunk_inline, "Preview [H]unk [I]nline")

      map("]g", function()
        gitsigns.nav_hunk("next")
      end, "Next hunk")

      map("[g", function()
        gitsigns.nav_hunk("prev")
      end, "Previous hunk")
    end,
  },
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    init = function()
      vim.keymap.set("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Fugitive UI" })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "%.git/", "%.venv/" },
          layout_config = { prompt_position = "top", height = 0.9, width = 0.9 },
          sorting_strategy = "ascending",
          prompt_prefix = " ",
          selection_caret = "  ",
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
              ["<C-c>"] = function()
                vim.cmd.stopinsert()
              end,
            },
          },
        },
      })

      telescope.load_extension("fzf")

      local map = function(keys, func, desc, mode)
        vim.keymap.set(mode or "n", keys, func, { desc = "Telescope: " .. desc })
      end

      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")

      map("<leader>f", function()
        builtin.find_files({ hidden = true })
      end, "[F]iles (workspace)")
      map("<leader>F", function()
        builtin.find_files({ hidden = true, cwd = utils.buffer_dir() })
      end, "[F]iles (buffer's directory)")

      map("<leader>b", function()
        builtin.buffers({ sort_mru = true })
      end, "[B]uffers")

      map("<leader>th", function()
        builtin.colorscheme({ enable_preview = true })
      end, "[Th]eme")

      map("<leader>/", builtin.live_grep, "Live Grep")
      map("<leader>gs", builtin.git_status, "[G]it [S]tatus")
      map("<leader>gc", builtin.git_commits, "[G]it [C]ommits")
      map("<leader>gh", builtin.git_bcommits, "[G]it File [H]istory")
      map("<leader>gb", builtin.git_branches, "[G]it [B]ranches")
      map("<leader>'", builtin.resume, "Resume")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { { "j-hui/fidget.nvim", config = true } },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("satoqz-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local telescope = require("telescope.builtin")

          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gd", telescope.lsp_definitions, "[G]oto [D]efinitions")
          map("gy", telescope.lsp_type_definitions, "[G]oto T[y]pe Definitions")
          map("gi", telescope.lsp_implementations, "[G]oto [I]mplementations")
          map("gr", telescope.lsp_references, "[G]oto [R]eferences")

          map("<leader>r", vim.lsp.buf.rename, "[R]ename")
          map("<leader>a", vim.lsp.buf.code_action, "Code [A]ction")

          map("<leader>s", telescope.lsp_document_symbols, "Document [S]ymbols")
          map("<leader>S", telescope.lsp_dynamic_workspace_symbols, "Workspace [S]ymbols")

          map("<leader>d", function()
            telescope.diagnostics({ bufnr = 1 })
          end, "Buffer [D]iagnostics")
          map("<leader>D", telescope.diagnostics, "Workspace [D]iagnostics")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>ti", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle [I]nlay Hints")
          end
        end,
      })

      local util = require("satoqz.util")

      for _, server in ipairs({
        "clangd",
        "gopls",
        "lua_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "zls",
      }) do
        util.setup_language_server(server)
      end

      vim.diagnostic.config({ signs = false })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          fish = { "fish_indent" },
          go = { "goimports", "gofmt" },
          lua = { "stylua" },
          python = { "ruff_format" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 1000, lsp_format = "fallback" }
        end,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(opts)
        if opts.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function(opts)
        if opts.bang then
          vim.b.disable_autoformat = false
        else
          vim.g.disable_autoformat = false
        end
      end, {
        desc = "Re-enable autoformat-on-save",
        bang = true,
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { { "xzbdmw/colorful-menu.nvim", config = true } },
    version = "*",
    config = function()
      require("blink.cmp").setup({
        keymap = { preset = "super-tab" },
        cmdline = { enabled = false },
        signature = { enabled = true },
        completion = {
          documentation = { auto_show = true },
          menu = {
            draw = {
              treesitter = { "lsp" },
              columns = { { "label" } },
              components = {
                label = {
                  text = require("colorful-menu").blink_components_text,
                  highlight = require("colorful-menu").blink_components_highlight,
                },
              },
            },
          },
        },
        sources = {
          default = { "lazydev", "lsp" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
      })
    end,
  },
}

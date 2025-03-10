return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      local theme = require("lualine.themes.gruvbox-material")
      theme.inactive = theme.normal
      for _, mode_colors in pairs(theme) do
        mode_colors.a.bg = theme.normal.a.bg
      end

      local encoding = {
        "encoding",
        cond = function() return vim.opt.fileencoding:get() ~= "utf-8" end,
      }

      local fileformat = {
        "fileformat",
        cond = function() return vim.bo.fileformat ~= "unix" end,
      }

      local diagnostics = {
        "diagnostics",
        sections = { "error", "warn" },
      }

      local filename = {
        "filename",
        path = 1,
        fmt = function(s)
          if vim.startswith(s, "fugitive://") then
            return "fugitive"
          end

          if vim.startswith(s, "oil://") then
            return vim.fn.fnamemodify(s:gsub("^oil://", ""), ":~")
          end

          return s
        end,
      }

      local recording = {
        function()
          local reg = vim.fn.reg_recording()
          if reg == "" then
            return ""
          end
          return "recording @" .. reg
        end,
      }

      local sections = {
        lualine_a = { "mode" },
        lualine_b = { filename },
        lualine_c = { diagnostics, recording },
        lualine_x = { encoding, fileformat },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }

      local inactive_sections = {
        lualine_a = { "mode" },
        lualine_b = { filename },
        lualine_c = { diagnostics },
        lualine_x = { encoding, fileformat },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }

      require("lualine").setup({
        sections = sections,
        inactive_sections = inactive_sections,
        options = {
          theme = theme,
        },
      })
    end,
  },
}

local schemes = {
  {
    plugin = "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    config = function()
      vim.g.gruvbox_material_show_eob = 0
    end,
  },
  {
    plugin = "sainnhe/sonokai",
    name = "sonokai",
    config = function()
      vim.g.sonokai_show_eob = 0
    end,
  },
  {
    plugin = "folke/tokyonight.nvim",
    name = "tokyonight",
  },
  {
    plugin = "catppuccin/nvim",
    name = "catppuccin",
  },
}

return vim.tbl_map(function(scheme)
  if scheme.name == vim.g.default_colorscheme then
    return {
      scheme.plugin,
      name = scheme.name,
      priority = 1000,
      config = function()
        (scheme.config or function() end)()
        vim.cmd.colorscheme(scheme.name)
      end,
    }
  else
    return {
      scheme.plugin,
      name = scheme.name,
      config = scheme.config or true,
    }
  end
end, schemes)

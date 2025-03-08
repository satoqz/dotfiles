return {
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      bigfile = {
        enabled = true,
      },
      notifier = {
        enabled = true,
        filter = function(n) return n.msg ~= "cargo check" end,
      },
      picker = {
        ui_select = false,
        layout = {
          layout = {
            width = 0.9,
            height = 0.9,
            backdrop = false,
          },
        },
        icons = {
          files = {
            enabled = false,
          },
        },
        win = {
          input = {
            keys = {
              ["<esc>"] = { "close", mode = { "n", "i" } },
              ["<c-c>"] = { function() vim.cmd.stopinsert() end, mode = { "i" } },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>f", function() Snacks.picker.files({ hidden = true }) end },
      {
        "<leader>F",
        function() Snacks.picker.files({ hidden = true, cwd = vim.fn.expand("%:p:h") }) end,
      },
      {
        "<leader><c-f>",
        function() Snacks.picker.files({ hidden = true, ignored = true }) end,
      },
      { "<leader>r", function() Snacks.picker.recent() end },
      { "<leader>b", function() Snacks.picker.buffers() end },
      { "<leader>j", function() Snacks.picker.jumps() end },
      { "<leader>u", function() Snacks.picker.undo() end },
      { "<leader>n", function() Snacks.picker.notifications() end },
      { "<leader>/", function() Snacks.picker.grep() end },
      { "<leader>gb", function() Snacks.picker.git_branches() end },
      { "<leader>gs", function() Snacks.picker.git_status() end },
      { "<leader>gla", function() Snacks.picker.git_log() end },
      { "<leader>glf", function() Snacks.picker.git_log_file() end },
      { "<leader>gll", function() Snacks.picker.git_log_line() end },
      { "<leader>'", function() Snacks.picker.resume() end },
    },
  },
}

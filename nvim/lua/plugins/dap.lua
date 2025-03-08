return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "leoluz/nvim-dap-go" },
    cmd = { "DapNew", "DapContinue", "DapToggleBreakpoint" },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end },
      { "<leader>dc", function() require("dap").continue() end },
      { "<leader>dp", function() require("dap").pause() end },
      { "<leader>dt", function() require("dap").terminate() end },
      { "<leader>dl", function() require("dap").run_last() end },
      { "<leader>dh", function() require("dap").run_to_cursor() end },
      { "<leader>di", function() require("dap").step_into() end },
      { "<leader>do", function() require("dap").step_out() end },
      { "<leader>dn", function() require("dap").step_over() end },
      { "<leader>dj", function() require("dap").down() end },
      { "<leader>dk", function() require("dap").up() end },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
    end,
    keys = {
      { "<leader>du", function() require("dapui").toggle() end },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" } },
    },
  },
}

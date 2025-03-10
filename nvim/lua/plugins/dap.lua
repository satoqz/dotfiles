return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "leoluz/nvim-dap-go" },
    cmd = { "DapNew", "DapContinue", "DapToggleBreakpoint" },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end },
      { "<leader>db", function() require("dap").toggle_breakpoint() end },
      { "<leader>dc", function() require("dap").continue() end },
      { "<leader>df", function() require("dap").focus_frame() end },
      { "<leader>dh", function() require("dap").run_to_cursor() end },
      { "<leader>di", function() require("dap").step_into() end },
      { "<leader>dj", function() require("dap").down() end },
      { "<leader>dk", function() require("dap").up() end },
      { "<leader>dl", function() require("dap").list_breakpoints(true) end },
      { "<leader>dn", function() require("dap").step_over() end },
      { "<leader>do", function() require("dap").step_out() end },
      { "<leader>dp", function() require("dap").pause() end },
      { "<leader>dr", function() require("dap").repl.toggle() end },
      { "<leader>dt", function() require("dap").terminate() end },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end },
    },
    config = function()
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "green", linehl = "Visual" })
      vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "red" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "?", texthl = "red" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "!", texthl = "red" })
    end,
  },
}

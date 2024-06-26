local M = { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }

function M.config()
  local dap, dapui = require("dap"), require("dapui")


  -- Automatically open/close the UI on debug actions
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- Setup UI
  dapui.setup({
    layouts = { {
      elements = { {
        id = "scopes",
        size = 0.25
      }, {
        id = "breakpoints",
        size = 0.25
      }, {
        id = "stacks",
        size = 0.25
      }, {
        id = "watches",
        size = 0.25
      } },
      position = "left",
      size = 50
    }, {
      elements = { {
        id = "console",
        size = 1
      } },
      position = "bottom",
      size = 10
    } },
  })

  -- Keymaps
  vim.keymap.set("n", "<leader>du", require("dapui").toggle)
end

return M

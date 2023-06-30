local M = { 'mfussenegger/nvim-dap' }

function M.config()
  local dap = require("dap")

  -- Breakpoint signs
  vim.fn.sign_define('DapBreakpoint',
    { text = '🟥', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected',
    { text = '🟦', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped',
    { text = '⭐️', texthl = '', linehl = '', numhl = '' })

  -- Key mappings
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
  vim.keymap.set("n", "<leader>dc", dap.continue)
  vim.keymap.set("n", "<leader>ds", dap.step_over)
  vim.keymap.set("n", "<leader>dS", dap.step_into)
  vim.keymap.set("n", "<leader>do", dap.repl.open)
  vim.keymap.set("n", "<leader>dh", require("dap.ui.widgets").hover)
end

return M

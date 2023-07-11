local M = { 'mfussenegger/nvim-dap' }

function M.config()
  local dap = require("dap")
  dap.set_log_level('DEBUG');

  -- Breakpoint signs
  vim.fn.sign_define('DapBreakpoint',
    { text = '🟥', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected',
    { text = '🟦', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped',
    { text = '⭐️', texthl = '', linehl = '', numhl = '' })

  -- PHP
  dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {
      require('mason-registry').get_package('php-debug-adapter'):get_install_path() .. "/extension/out/phpDebug.js"
    }
  }

  dap.configurations.php = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 9000
    }
  }


  -- Rust/C/C++
  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = require('mason-registry').get_package('codelldb'):get_install_path() .. '/extension/adapter/codelldb',
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    }
  }

  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }


  -- Debug key mappings
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
  vim.keymap.set("n", "<leader>dc", dap.continue)
  vim.keymap.set("n", "<leader>ds", dap.step_over)
  vim.keymap.set("n", "<leader>di", dap.step_into)
  vim.keymap.set("n", "<leader>do", dap.repl.open)
  vim.keymap.set("n", "<leader>dh", require("dap.ui.widgets").hover)
  vim.keymap.set("n", "<leader>dx", dap.clear_breakpoints)
end

return M

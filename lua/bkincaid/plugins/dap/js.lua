local M = {
  "mxsdev/nvim-dap-vscode-js",
  dependencies = {
    "mfussenegger/nvim-dap",
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }
  },
}

function M.config()
  local dap = require('dap')

  -- Set up vscode-js-debug adapters
  require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
    adapters = { 'pwa-node', 'pwa-chrome' }
  })


  -- Extend pwa-chrome to ask for the port before opening the Chrome instance
  local custom_chrome_adapter = 'pwa-chrome-custom'
  dap.adapters[custom_chrome_adapter] = function(_, config)
    vim.ui.input({
      prompt = "Which port? (3000)"
    }, function(port)
      port = port or 3000
      config.url = "http://localhost:" .. port
      config.type = 'pwa-chrome'
      dap.run(config)
    end)
  end


  -- Register JS/TS configurations
  for _, language in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do
    require("dap").configurations[language] = {
      -- Run the current buffer via node in inspect mode
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file (Node)",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      -- Launch a dedicated chrome instance w/ debugging enabled
      {
        type = custom_chrome_adapter,
        request = "launch",
        name = "Launch (Chrome)",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
      },
      -- Attach to a running node process
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Process (Node)",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end
end

return M

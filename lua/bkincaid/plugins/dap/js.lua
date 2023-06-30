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
  require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
    adapters = { 'pwa-node', 'pwa-chrome' }
  })

  for _, language in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do
    require("dap").configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file (Node)",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch (Chrome)",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
      },
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

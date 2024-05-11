local M = {
  "leoluz/nvim-dap-go",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}

function M.setup()
  require("dap-go").setup()
end

return M

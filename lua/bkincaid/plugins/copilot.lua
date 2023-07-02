local M = {
  'github/copilot.vim'
}

function M.config()
  local disabled_filetypes = {
    'dap-repl',
    'dapui_watches',
    'dapui_stacks',
    'dapui_breakpoints',
    'dapui_scopes',
    'dap-repl',
    'dapui_console'
  }

  local filetypes = {}

  for _, filetype in ipairs(disabled_filetypes) do
    filetypes[filetype] = false
  end

  vim.g.copilot_filetypes = filetypes
end

return M

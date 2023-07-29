local M = {
  'nvim-lualine/lualine.nvim'
}

function M.config()
  local disabled_filetypes = { 'packer', 'NvimTree', 'alpha', 'dapui_watches', 'dapui_stacks', 'dapui_breakpoints',
    'dapui_scopes', 'dap-repl', 'dapui_console' }
  local disabled_win_filetypes = { 'packer', 'NvimTree', 'alpha', 'gitcommit', 'help', 'fugitive' }

  require('lualine').setup({
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { 'filename', path = 0 } },
      lualine_c = { 'diff', 'diagnostics' },
      lualine_x = { 'branch', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    options = {
      disabled_filetypes = {
        statusline = disabled_filetypes,
        winbar = disabled_win_filetypes,
        inactive_winbar = disabled_win_filetypes
      }
    },
    winbar = {
      lualine_c = { { 'filename', file_status = true, path = 4 } }
    },
    inactive_winbar = {
      lualine_c = { { 'filename', file_status = true, path = 4 } }
    },
    extensions = { 'fugitive', 'quickfix', 'nvim-dap-ui' }
  })
end

return M

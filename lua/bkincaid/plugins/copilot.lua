local M = {
  'github/copilot.vim'
}

function M.config()
  vim.g.copilot_filetypes = {
    -- Disable copilot in nvim-dap repl
    -- https://github.com/neovim/neovim/issues/17614
    ['dap-repl'] = false
  }
end

return M

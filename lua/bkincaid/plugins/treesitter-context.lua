local M = { 'nvim-treesitter/nvim-treesitter-context', commit = 'f6c99b6' }

function M.config()
  require('treesitter-context').setup {
    enable = true
  }
end

return M

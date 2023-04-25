local M = { 'nvim-treesitter/nvim-treesitter-context' }

function M.config()
  require('treesitter-context').setup {
    enable = true
  }
end

return M

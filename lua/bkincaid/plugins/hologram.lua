local M = { 'edluffy/hologram.nvim' }


function M.config()
  require('hologram').setup {
    auto_display = true -- WIP automatic markdown image display, may be prone to breaking
  }
end

return M

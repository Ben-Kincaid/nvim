local M = { 'akinsho/toggleterm.nvim', version = '*' }

function M.config()
  require('toggleterm').setup({
    size = 20,
    open_mapping = [[<c-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'curved',
      width = 120,
      height = 30,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  })
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

  function _TERMINAL_LAZYGIT()
    lazygit:toggle()
  end
end

return M

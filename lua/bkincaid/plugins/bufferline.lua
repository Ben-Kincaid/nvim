local M = {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}

function M.config()
  require("bufferline").setup {
    options = {
      separator_style = "slant",
      offsets = {
        {
          filetype = "NvimTree",
          text = "",
          separator = true,
        }
      }
    }
  }
end

return M

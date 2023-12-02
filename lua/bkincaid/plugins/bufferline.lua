local M = {
  'akinsho/bufferline.nvim',
  version = "v3.*",
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}

function M.config()
  require("bufferline").setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
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

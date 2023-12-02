local M = {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = 'catppuccin'
}


function M.config()
  require('catppuccin').setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
    }
  });
  vim.cmd.colorscheme 'catppuccin-mocha'
end

return M

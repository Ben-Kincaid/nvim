local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim' }
}

function M.config()
  local harpoon = require('harpoon')
  harpoon:setup()

  vim.keymap.set('n', "<leader>a", function() harpoon:list():append() end)
  vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

  vim.keymap.set("n", "<C-g>", function() harpoon:list():next() end)
  vim.keymap.set("n", "<C-f>", function() harpoon:list():prev() end)
end

return M

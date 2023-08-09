local M = { 'echasnovski/mini.files', version = false }

function M.config()
  local mf = require('mini.files')
  mf.setup({
    mappings = {
      close       = '<leader>q',
      go_in_plus  = '<CR>',
      go_out      = '.',
      reset       = '<BS>',
      reveal_cwd  = '@',
      show_help   = 'g?',
      synchronize = '=',
      trim_left   = '<',
      trim_right  = '>',
    }
  })

  vim.keymap.set('n', '<leader>b', function()
    if not mf.close() then mf.open() end
  end)
end

return M

-- local M = {
--   'nvim-tree/nvim-tree.lua',
--   dependencies = {
--     'nvim-tree/nvim-web-devicons', -- optional, for file icons
--   },
--   lazy = false,
--   priority = 999,
--   version = 'nightly' -- optional, updated every week. (see issue #1193)
-- }


-- function M.config()
--   vim.g.loaded_netrw = 1
--   vim.g.loaded_netrwPlugin = 1

--   -- Follow current buffer in file tree
--   vim.g.nvim_tree_follow = 1

--   -- empty setup using defaults
--   require("nvim-tree").setup({
--     update_focused_file = {
--       enable = true,
--       ignore_list = { "help" },
--     }
--   })

--   vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>")
-- end

-- return M

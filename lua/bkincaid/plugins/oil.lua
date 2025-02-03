local M = {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  local oil = require("oil")

  oil.setup(
    {
      columns = {
        "icon",
        {"size", highlight = "Blamer"}
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<leader>q"] = "actions.close",
        ["<C-c>"] = "",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["<C-i>"] = "actions.toggle_hidden",
      }
    })

  vim.keymap.set("n", "<leader>b", require("oil").open, { desc = "Open parent directory" })
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

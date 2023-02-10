-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Follow current buffer in file tree
vim.g.nvim_tree_follow = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
		ignore_list = { "help" },
	}
})

vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>")

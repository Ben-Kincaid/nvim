vim.opt.termguicolors = true
require("bufferline").setup {
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				separator = true,
			},
			{
				filetype = "fugitive",
				text = "Git (fugitive)",
				separator = true,
			}
		}
	}
}

local M = {
	'akinsho/bufferline.nvim',
	version = "v3.*",
	dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' }
}


function M.config()
	require("bufferline").setup {
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
		options = {
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					separator = true,
				}
			}
		}
	}
end


return M

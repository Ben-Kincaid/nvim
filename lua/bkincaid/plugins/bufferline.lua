local M = {
	'akinsho/bufferline.nvim',
	version = "v3.*",
	dependencies = { 'nvim-tree/nvim-web-devicons' }
}


function M.config()
	require("bufferline").setup {
		options = {
			separator_style = "slant",
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

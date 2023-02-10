require('lualine').setup({
	sections = {
		lualine_b = {
			{
				'filename',
				path = 0
			}
		},
		lualine_c = {
			{
				'filename',
				path = 1
			}

		}
	},
	options = {
		disabled_filetypes = { statusline = { 'packer', 'NvimTree', 'alpha', 'help' } }
	}
})

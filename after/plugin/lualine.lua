local disabled_filetypes = { 'packer', 'NvimTree', 'alpha' }


require('lualine').setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { 'filename', file_status = true, newfile_status = false, path = 1 } },
		lualine_c = { { 'filename', path = 0 } },
		lualine_x = { 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	options = {
		theme = "catppuccin",
		disabled_filetypes = { statusline = disabled_filetypes, winbar = disabled_filetypes }
	}
})

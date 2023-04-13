local M = {
	'nvim-lualine/lualine.nvim'
}


function M.config()
	local disabled_filetypes = { 'packer', 'NvimTree', 'alpha' }
	local disabled_win_filetypes = { 'packer', 'NvimTree', 'alpha', 'gitcommit', 'help', 'fugitive' }

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
			theme = "tokyonight",
			disabled_filetypes = {
				statusline = disabled_filetypes,
				winbar = disabled_win_filetypes,
				inactive_winbar = disabled_win_filetypes
			}
		},
		winbar = {
			lualine_c = { { 'filename', file_status = true, path = 1 } }
		},
		inactive_winbar = {
			lualine_c = { { 'filename', file_status = true, path = 1 } }
		}
	})
end

return M

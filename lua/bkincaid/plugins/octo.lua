local M = {
	'pwntester/octo.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
		'nvim-tree/nvim-web-devicons',
	}
}

function M.config()
	require('octo').setup()
end

return M

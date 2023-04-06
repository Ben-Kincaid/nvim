local M = {
	'hrsh7th/nvim-cmp',
	dependencies = {
		"L3MON4D3/LuaSnip",
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
	}
}


function M.config()
	require('bkincaid.plugins.lsp.cmp')
end

return M

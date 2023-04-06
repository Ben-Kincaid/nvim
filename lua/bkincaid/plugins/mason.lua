local M = {
	"williamboman/mason.nvim",
	build = ":MasonUpdate" -- :MasonUpdate updates registry contents
}

function M.config()
	require('mason').setup()
end

return M

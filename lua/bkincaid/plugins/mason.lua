local M = {
	"williamboman/mason.nvim",
	build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  priority = 100,
}

function M.config()
	require('mason').setup()
end

return M

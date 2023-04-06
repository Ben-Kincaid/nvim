local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" }
}

function M.config()
	require("mason-lspconfig").setup {
		automatic_installation = true
	}
end

return M

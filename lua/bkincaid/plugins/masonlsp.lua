local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" },
  lazy = false,
  priority = 901,
}

function M.config()
	require("mason-lspconfig").setup {
		automatic_installation = true
	}
end

return M

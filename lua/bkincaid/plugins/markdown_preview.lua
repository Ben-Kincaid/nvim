local M = {
	"iamcco/markdown-preview.nvim",
	build = function() vim.fn["mkdp#util#install"]() end,
}

function M.config()
	vim.g.mkdp_browser = "Brave Browser"
	vim.g.mkdp_echo_preview_url = 1
end

return M

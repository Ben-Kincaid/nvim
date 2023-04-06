local M = {
	"Ben-Kincaid/yuphelp.nvim"
}


function M.config()
	require("yuphelp").setup()
	vim.keymap.set("n", "<leader>yh", ":YupHelp<CR>")
end


return M

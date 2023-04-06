local M = {	
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
}

function M.config()	
	local alpha = require("alpha")
	local startify = require("alpha.themes.startify")
	startify.section.header.val = {
		"██████  ██   ██ ██ ███    ██  ██████  █████  ██ ██████ ",
		"██   ██ ██  ██  ██ ████   ██ ██      ██   ██ ██ ██   ██",
		"██████  █████   ██ ██ ██  ██ ██      ███████ ██ ██   ██",
		"██   ██ ██  ██  ██ ██  ██ ██ ██      ██   ██ ██ ██   ██",
		"██████  ██   ██ ██ ██   ████  ██████ ██   ██ ██ ██████ "
	}


	startify.section.top_buttons.val = {
		startify.button("e", "New file", "<cmd>ene <CR>"),
	}


	alpha.setup(startify.opts)

	-- Disable folding on alpha buffer
	vim.cmd([[
		autocmd FileType alpha setlocal nofoldenable
	]])
end


return M

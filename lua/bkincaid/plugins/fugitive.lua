local M = { 'tpope/vim-fugitive' }


function M.config()
	vim.keymap.set("n", "<leader>g", vim.cmd.Git)

	-- View git files
	vim.keymap.set('n', '<leader>G', function()
		vim.ui.input({
			prompt = 'Compare with target branch/commit > '
		}, function(input)
			vim.cmd(":Git difftool -y " .. input);
		end)
	end)
end

return M

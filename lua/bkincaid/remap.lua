vim.g.mapleader = " "

-- Save & quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>X", "<cmd>qa!<cr>")


-- Use ]b and [b to navigate buffers
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")

-- Map ctrl-c to esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Replace all instances of cursor word
vim.keymap.set("n", "<leader>R", function()
	local cword = vim.call('expand', '<cword>')

	vim.ui.input({
		prompt = 'Replace all "' .. cword .. '" with > '
	}, function(input)
		vim.cmd(":%s/" .. cword .. "/" .. input .. "/g")
	end)
end)

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

function PushToReg(str)
	vim.cmd('let @+="' .. str .. '"')
	vim.notify('Copied "' .. str .. '"!')
end

function CopyFile(absolute)
	local path

	-- Determine appropriate path depth
	if absolute then
		path = vim.fn.expand('%:p')
	else
		path = vim.fn.expand("%:.")
	end

	-- Add path to registry
	PushToReg(path)
end

-- Copy relative path
vim.keymap.set("n", "<leader>CC", function()
	CopyFile(false);
end)

-- Copy absolute path
vim.keymap.set("n", "<leader>CX", function()
	CopyFile(true);
end)

-- Copy file name
vim.keymap.set("n", "<leader>CF", function()
	local fn = vim.fn.expand('%:t')
	PushToReg(fn);
end)

-- Copy file name + line row
vim.keymap.set("n", "<leader>CL", function()
	local fn = vim.fn.expand('%:t')
	local ln, _ = unpack(vim.api.nvim_win_get_cursor(0))
	PushToReg(fn .. ":" .. ln)
end)

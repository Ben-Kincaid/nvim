vim.g.mapleader = " "

-- Save & quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>:tabclose<cr>");
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
		vim.notify("Replaced all instances of \"" .. cword .. "\" with \"" .. input .. "\".", "info", { title = "Replace \"" .. cword .. "\"" })
	end)
end)

function PushToReg(str)
	vim.cmd('let @+="' .. str .. '"')
	vim.notify('Copied "' .. str .. '"!', 'info', { title = "File path copied." })
end

function CopyFile(absolute)
	local path

	-- Determine appropriate path depth
	if absolute then
		path = vim.fn.expand('%:p')
	else
		path = vim.fn.expand("%:.")
	end

	if path == "" then
		vim.notify("No file in current buffer.", "error", { title = "File path copy failed." })
		return
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

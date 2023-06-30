vim.g.mapleader = " "

-- Save & quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>:tabclose<cr>");
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>X", "<cmd>qa!<cr>")

-- Move selection up & down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle when pd/pu 
vim.keymap.set("n", "<C-d>", "<C-d>zz");
vim.keymap.set("n", "<C-u>", "<C-u>zz");

-- Keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste in visual while not storing deleted text in register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Use ]b and [b to navigate buffers
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")

-- Map ctrl-c to esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Replace all instances of cursor word
vim.keymap.set("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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

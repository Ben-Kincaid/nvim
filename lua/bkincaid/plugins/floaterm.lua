local M = { 'voldikss/vim-floaterm' }

local test = "wow"

function M.config()
	-- Let's revisit this; fugitive + gitsigns workflow is pretty nice
	-- Lazygit seems great but i don't like having different keybindings for something that behaves like a nvim plugin with floaterm
	-- vim.keymap.set("n", "<leader>tg", ":FloatermNew --width=0.85 --height=0.85 lazygit<CR>", { noremap = true, silent = true })
end


return M

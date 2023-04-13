local M = { 'voldikss/vim-floaterm' }


local test = "wow"
print(test)

function M.config()
		vim.keymap.set("n", "<leader>tg", ":FloatermNew --width=0.85 --height=0.85 lazygit<CR>", { noremap = true, silent = true })
end


return M

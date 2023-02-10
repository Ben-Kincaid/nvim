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

-- Extend start screen with nvim-tree functionality
if packer_plugins["nvim-tree.lua"] then
	table.insert(startify.section.top_buttons.val, startify.button("b", "Show file tree", "<cmd>NvimTreeToggle<CR>"))
end

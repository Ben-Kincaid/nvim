local M = {
	"iamcco/markdown-preview.nvim",
	build = function() vim.fn["mkdp#util#install"]() end,
}


-- Check if a given dir/file exists
function CheckDirExists(dir)
	local ok, err, code = os.rename(dir, dir)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end

	return ok, err
end

-- Set the correct value for mkdp_browser
-- Will check for brave/chrome/firefox and set the appropriate browser to use
-- Accepts a table with an ordered set of browser priorities
-- Note: this will only work on MacOS & assumes default naming of browser applications ("Brave Browser", "Google Chrome", etc)
function SetInstalledBrowser(priorities)
	local default_priorities = { "brave", "chrome", "firefox" }
	priorities = priorities or default_priorities

	local brave_install_dir = "/Applications/Brave Browser.app"
	local chrome_install_dir = "/Applications/Google Chrome.app"
	local firefox_install_dir = "/Applications/Firefox.app"

	local install_dir_map = {
		brave = brave_install_dir,
		chrome = chrome_install_dir,
		firefox = firefox_install_dir
	}

	local name_map = {
		brave = "Brave Browser",
		chrome = chrome_install_dir,
		firefox = firefox_install_dir
	}

	for _, target in pairs(priorities) do
		local browser_path = install_dir_map[target]

		local exists = CheckDirExists(browser_path)

		if exists then
			vim.g.mkdp_browser = name_map[target]
			break
		end
	end
end

function M.config()
	-- Don't autoclose the browser/server when closing buffer
	vim.g.mkdp_auto_close = 0
	-- Echo the preview URL to confirm server start
	vim.g.mkdp_echo_preview_url = 1

	-- Auto detect browser to use for opening the preview
	local browser_priorities = { "brave", "chrome", "firefox" }
	SetInstalledBrowser(browser_priorities)

	-- Open markdown preview
	vim.keymap.set("n", "<leader>M", "<cmd>MarkdownPreviewToggle<CR>")
end

return M

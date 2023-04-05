local fzf = require('fzf-lua')

fzf.setup {
	fzf_opts = {
		['--keep-right'] = ''
	}
}

-- Find file by name in cwd
vim.keymap.set('n', '<leader>o', fzf.files, {})

-- Find string in cwd
vim.keymap.set('n', '<leader>f', function()
	fzf.live_grep()
end)

-- View help files
vim.keymap.set('n', '<leader>h', fzf.help_tags, {})

-- View current buffers
vim.keymap.set('n', '<leader>`', fzf.buffers, {})

-- Search current working directory for word under the cursor
vim.keymap.set('n', '<leader>F', fzf.grep_cword, {})

-- Search in directory relative to project root
vim.keymap.set({ 'n', 'v' }, '<leader>df', function()
	-- Check if a given path actually exists
	local function exists(file)
		local ok, err = os.rename(file, file)
		return ok, err
	end

	local cwd --- Check if a file or directory exists in this path

	vim.ui.input({
		prompt = 'Search in directory > '
	}, function(input)
		local is_absolute = string.sub(input, 1, 1) == "/"

		if (is_absolute) then
			cwd = input
		else
			cwd = vim.fn.getcwd() .. '/' .. input
		end

		local ok = exists(cwd)

		if ok then
			fzf.live_grep({ cwd = cwd })
		else
			vim.notify('"' .. cwd .. '" Does not exist.')
		end
	end)
end)



---- Find file in cwd
--vim.keymap.set('n', '<leader>o', builtin.find_files, {})
---- Find string in cwd
--vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
---- View help files
--vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
---- View current buffers
--vim.keymap.set('n', '<leader>`', builtin.buffers, {})
---- View/find git files
--vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
---- Search current working directory for word under cursor
--vim.keymap.set("n", "<leader>F", builtin.grep_string, {})
---- Search in directory relative to project root
--vim.keymap.set('n', '<leader>tf', function()
--	-- Check if a given path actually exists
--	local function exists(file)
--		local ok, err = os.rename(file, file)
--		return ok, err
--	end
--
--	local cwd --- Check if a file or directory exists in this path
--
--	vim.ui.input({
--		prompt = 'Search in directory > '
--	}, function(input)
--		local is_absolute = string.sub(input, 1, 1) == "/"
--
--		if (is_absolute) then
--			cwd = input
--		else
--			cwd = vim.fn.getcwd() .. '/' .. input
--		end
--
--		local ok = exists(cwd)
--
--		if ok then
--			builtin.live_grep({ cwd = cwd })
--		else
--			vim.notify('"' .. cwd .. '" Does not exist.')
--		end
--	end)
--end)


--require('telescope').setup {
--	defaults = {
--		vimgrep_arguments = {
--			"rg",
--			"-L",
--			"--color=never",
--			"--no-heading",
--			"--with-filename",
--			"--line-number",
--			"--column",
--			"--smart-case",
--		},
--		prompt_prefix = " 🔍  ",
--		selection_caret = "  ",
--		entry_prefix = "  ",
--		initial_mode = "insert",
--		selection_strategy = "reset",
--		sorting_strategy = "ascending",
--		layout_strategy = "horizontal",
--		layout_config = {
--			horizontal = {
--				prompt_position = "top",
--				preview_width = 0.55,
--				results_width = 0.8,
--			},
--			vertical = {
--				mirror = false,
--			},
--			width = 0.87,
--			height = 0.80,
--			preview_cutoff = 120,
--		},
--		file_sorter = require("telescope.sorters").get_fuzzy_file,
--		file_ignore_patterns = { "node_modules" },
--		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
--		path_display = { "truncate" },
--		winblend = 0,
--		border = {},
--		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--		color_devicons = true,
--		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
--		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
--		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
--		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--		-- Developer configurations: Not meant for general override
--		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
--		mappings = {
--			n = { ["q"] = require("telescope.actions").close },
--		},
--	},
--
--	extensions_list = { "themes", "terms" },
--}
--
--local builtin = require('telescope.builtin')
--
--
---- Find file in cwd
--vim.keymap.set('n', '<leader>o', builtin.find_files, {})
---- Find string in cwd
--vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
---- View help files
--vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
---- View current buffers
--vim.keymap.set('n', '<leader>`', builtin.buffers, {})
---- View/find git files
--vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
---- Search current working directory for word under cursor
--vim.keymap.set("n", "<leader>F", builtin.grep_string, {})
---- Search in directory relative to project root
--vim.keymap.set('n', '<leader>tf', function()
--	-- Check if a given path actually exists
--	local function exists(file)
--		local ok, err = os.rename(file, file)
--		return ok, err
--	end
--
--	local cwd --- Check if a file or directory exists in this path
--
--	vim.ui.input({
--		prompt = 'Search in directory > '
--	}, function(input)
--		local is_absolute = string.sub(input, 1, 1) == "/"
--
--		if (is_absolute) then
--			cwd = input
--		else
--			cwd = vim.fn.getcwd() .. '/' .. input
--		end
--
--		local ok = exists(cwd)
--
--		if ok then
--			builtin.live_grep({ cwd = cwd })
--		else
--			vim.notify('"' .. cwd .. '" Does not exist.')
--		end
--	end)
--end)

local M = {
	'nvim-telescope/telescope.nvim',
	version = '0.1.1',
	dependencies = { { 'nvim-lua/plenary.nvim' } }
}


function M.config()
	local builtin = require('telescope.builtin')

	require('telescope').setup {
		defaults = {
		},
		pickers = {
			find_files = {
				results_title = false,
				preview_title = false,
				prompt_title = false,
				theme = "dropdown",
				previewer = false,
				layout_config = {
					anchor = "N",
					width = 90
				}
			},
			live_grep = {
				results_title = false,
				theme = "ivy",
			},
			buffers = {
				results_title = false,
				theme = "ivy",
			},
			help_tags = {
				results_title = false,
				theme = "ivy",
			},
			grep_string = {
				results_title = false,
				theme = "ivy",
			}
		},
		path_display = {
			shorten = {
				len = 3, exclude = { 1, -1 }
			},
			truncate = true,
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case"
			}
		}
	}

	require('telescope').load_extension('fzf');

	-- Find file in cwd
	vim.keymap.set('n', '<leader>o', builtin.find_files, {})
	-- Grep string in cwd
	vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
	-- View help files
	vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
	-- View current buffers
	vim.keymap.set('n', '<leader>`', builtin.buffers, {})
	-- Search current working directory for word under cursor
	vim.keymap.set("n", "<leader>F", builtin.grep_string, {})
	-- Search in directory relative to project root
	vim.keymap.set('n', '<leader>id', function()
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
				builtin.live_grep({ cwd = cwd })
			else
				vim.notify('"' .. cwd .. '" Does not exist.', "error", { title = "Search in directory" })
			end
		end)
	end)
end


return M

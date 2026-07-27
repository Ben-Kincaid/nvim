local M = { 'nvim-treesitter/nvim-treesitter', branch = 'main', build = ':TSUpdate', lazy = false }

function M.config()
	require('nvim-treesitter').install {
		'c', 'lua', 'rust', 'vim', 'typescript', 'javascript', 'go', 'php', 'astro',
	}

	-- Start treesitter highlighting for any buffer whose filetype has a parser.
	vim.api.nvim_create_autocmd('FileType', {
		callback = function(args)
			pcall(vim.treesitter.start, args.buf)
		end,
	})
end

return M

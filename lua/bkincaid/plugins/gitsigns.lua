local M = { 'lewis6991/gitsigns.nvim' }

function M.config()
	local gs = require('gitsigns')

	gs.setup {
		on_attach = function()
			-- Navigation
			vim.keymap.set('n', ']c', function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() gs.next_hunk() end)
				return '<Ignore>'
			end, { expr = true })

			vim.keymap.set('n', '[c', function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function() gs.prev_hunk() end)
				return '<Ignore>'
			end, { expr = true })
		end
	};

	-- Actions
end

return M

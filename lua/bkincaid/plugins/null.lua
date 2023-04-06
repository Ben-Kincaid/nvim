local M = {
	'jose-elias-alvarez/null-ls.nvim',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/prettier.nvim"
	}
}


function M.config()
	-- ## null-ls: Supporting lagnuages that dont follow LSP ##"camera_offset"   "226.06 73.87 64.82"
	local lsp_formatting = function(bufnr)
		vim.lsp.buf.format({
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end

	-- if you want to set up formatting on save, you can use this as a callback
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	-- add to your shared on_attach callback
	local on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end

	require("null-ls").setup({
		on_attach = on_attach
	})

	-- ## Setup prettier.nvim; integrates prettier in LSP with null-ls
	local prettier = require("prettier");
	prettier.setup({
		bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
		filetypes = {
			"css",
			"graphql",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"less",
			"markdown",
			"scss",
			"typescript",
			"typescriptreact",
			"yaml",
			"svelte"
		},
	})
end

return M

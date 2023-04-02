-- ## nvim-lspconfig: Setup specific LSP servers ##
local lspconfig = require('lspconfig')

-- Rust
lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {

		},
	},
}

-- TS/JS
lspconfig.tsserver.setup {}
vim.api.nvim_create_autocmd("BufRead", {
	pattern = "tsconfig.json",
	callback = function()
		vim.cmd("set filetype=jsonc")
	end
})


-- Golang
lspconfig.gopls.setup {}
-- Lua
lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			}
		}
	}
}

-- CSS Modules
lspconfig.cssmodules_ls.setup {}
-- ESLint
lspconfig.eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
-- CSS
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup {
	capabilities = capabilities,
}
-- JSON
lspconfig.jsonls.setup {
	capabilities = capabilities,
}
-- HTML
lspconfig.html.setup {
	capabilities = capabilities,
}
-- Svelte
lspconfig.svelte.setup {}

-- TailwindCSS
lspconfig.tailwindcss.setup {}


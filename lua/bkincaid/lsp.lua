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

-- CSS
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup {
	capabilities = capabilities,
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
-- JSON
lspconfig.jsonls.setup {
	capabilities = capabilities,
}


-- ## Mason: manage LSP servers ##
require('mason').setup()
require("mason-lspconfig").setup {
	automatic_installation = true
}




-- ## Code completion ##
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require 'luasnip'.lsp_expand(args.body)
		end
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer',  keyword_length = 5 },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'neorg' }
	},
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<Enter>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
	}),
	experimental = {
		ghost_text = true
	}
})

-- ## Global LSP mappings ##
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<space><Enter>', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

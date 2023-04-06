-- ## Code completion ##
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require 'luasnip'.lsp_expand(args.body)
		end
	},
	sources = {
		{ name = 'nvim_lsp', max_item_count = 25 },
		{ name = 'buffer',  keyword_length = 5 },
		{ name = 'path' },
		{ name = 'luasnip' },
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

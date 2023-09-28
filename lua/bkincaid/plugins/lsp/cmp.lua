local M = {
  'hrsh7th/nvim-cmp',
  priority = 903,
  lazy = false,
  dependencies = {
    "L3MON4D3/LuaSnip",
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
  }
}


function M.config()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        require 'luasnip'.lsp_expand(args.body)
      end
    },
    sources = {
      { name = 'nvim_lsp', max_item_count = 25 },
      { name = 'buffer',   keyword_length = 5 },
      { name = 'path' },
      { name = 'luasnip' },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Enter>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
    })
  })
end

return M

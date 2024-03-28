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
    -- Pictograms for completion items
    'onsails/lspkind.nvim'
  }
}

function M.config()
  local cmp = require('cmp')

  cmp.setup({
    window = {
      documentation = cmp.config.window.bordered(),
      completion = cmp.config.window.bordered({
        col_offset = -3,
        side_padding = 0,
      }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    (" .. (strings[2] or "") .. ")"

        return kind
      end,
    },
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

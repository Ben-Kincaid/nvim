local M = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}

function M.config()
  -- ## null-ls: Supporting languages that dont provide an actual LSP server
  local null = require("null-ls");

  null.setup({
    sources = {
      null.builtins.formatting.pint,
      null.builtins.formatting.phpcsfixer,
      null.builtins.formatting.prettierd,
    }
  })
end

return M

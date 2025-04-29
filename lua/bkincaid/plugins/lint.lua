local M = {
  'mfussenegger/nvim-lint',
}

function M.config()
  local lint = require("lint")
  lint.linters_by_ft = {
    lua = { "luacheck" },
  }

  lint.try_lint()

  -- Run linter on save
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "BufNewFile"}, {
    callback = function()
      lint.try_lint()
    end,
  })
end

return M

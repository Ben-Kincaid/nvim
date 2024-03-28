local M = { 'mhartington/formatter.nvim' }

function M.config()
  local prettier = require("formatter.defaults.prettier")
  local js = {
    prettier,
  }


  require('formatter').setup({
    logging = false,
    filetype = {
      typescript = js,
      typescriptreact = js,
      javascript = js,
      javascriptreact = js,
      astro = js,
      json = { prettier },
      css = { prettier },
      scss = { prettier },
      sass = { prettier }
    }
  })


  vim.cmd [[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost * FormatWrite
    augroup END
  ]]
end

return M

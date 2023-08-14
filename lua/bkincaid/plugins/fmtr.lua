local M = { 'mhartington/formatter.nvim' }

function M.config()
  require('formatter').setup({
    logging = false,
    filetype = {
      typescript = {
        function()
          return {
            exe = "prettierd",
            args = { vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end
      },
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

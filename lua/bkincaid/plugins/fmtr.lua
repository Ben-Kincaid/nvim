local M = { 'mhartington/formatter.nvim' }

function M.config()
  local root_patterns = { 'biome.json' }
  local biome_root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])


  -- Determine which formatter (biome or prettier) to use
  local fmtr = require('formatter.defaults.prettier')
  if biome_root_dir then
    vim.notify('Using biome over prettier...')
    fmtr = require('formatter.defaults.biome')
  end

  local js = {
    fmtr,
  }

  require('formatter').setup({
    logging = false,
    filetype = {
      typescript = js,
      typescriptreact = js,
      javascript = js,
      javascriptreact = js,
      astro = js,
      json = { fmtr },
      css = { fmtr },
      scss = { fmtr },
      sass = { fmtr }
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

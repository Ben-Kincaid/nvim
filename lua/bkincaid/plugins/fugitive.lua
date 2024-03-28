local M = { 'tpope/vim-fugitive' }


function M.config()
  vim.keymap.set("n", "<leader>g", vim.cmd.Git)

  -- View diff between current buffer on another branch/commit.
  vim.keymap.set('n', '<leader><c-g>', function()
    vim.ui.input({
      prompt = '[Current File] Compare with target branch/commit > '
    }, function(input)
      vim.cmd(":Gvdiff " .. input);
    end)
  end)

  -- View diff between current working tree and branch/commit (a la Pull Request)
  -- Using difftool, each file diff will be opened in a new tab
  vim.keymap.set('n', '<leader>G', function()
    vim.ui.input({
      prompt = '[Current Branch] Compare with target branch/commit > '
    }, function(input)
      vim.cmd(":Git difftool -y " .. input);
    end)
  end)
end

return M

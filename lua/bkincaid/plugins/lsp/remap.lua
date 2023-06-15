-- Create fmt group & save FOS var to track format-on-save setting
local fmt_group = vim.api.nvim_create_augroup('UserLspFormat', {})
local fos = true;

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


    -- Handle dynamic "format on save" functionality
    local function toggle_format_on_save(state, log)
      -- If not provided, default 'log' to true
      log = log == nil and true or log

      -- Update FOS state
      fos = state

      if state == true then
        vim.api.nvim_create_autocmd('BufWritePre', {
          pattern = "<buffer>",
          group = fmt_group,
          callback = function()
            vim.lsp.buf.format { async = true }
          end,
        })
        if log then
          vim.notify("Format on save enabled", vim.log.levels.INFO, {
            title = "LSP",
          });
        end
      else
        vim.api.nvim_clear_autocmds({ group = fmt_group })
        if log then
          vim.notify("Format on save disabled", vim.log.levels.INFO, {
            title = "LSP",
          });
        end
      end
    end

    -- Create commands to toggle format on save & check current setting
    vim.api.nvim_create_user_command("LspFormatOnSave", function(cmd)
      if cmd.args == "on" then
        toggle_format_on_save(true)
      else
        toggle_format_on_save(false)
      end
    end, {
      nargs = 1,
      complete = function()
        return { "on", "off" }
      end
    })

    vim.api.nvim_create_user_command("LspFormatOnSaveToggle", function()
      toggle_format_on_save(not fos)
    end, { nargs = 0 })

    vim.api.nvim_create_user_command("LspFormatOnSaveInfo", function()
      vim.notify("Format on save is " .. (fos and "enabled" or "disabled"), vim.log.levels.INFO, {
        title = "LSP",
      });
    end, { nargs = 0 })

    -- Trigger format on save toggle based on default FOS
    toggle_format_on_save(fos, false)
  end,
})

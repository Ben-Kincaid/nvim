-- Create fmt group & save FOS var to track format-on-save setting
local fmt_group = vim.api.nvim_create_augroup('UserLspFormat', {})
local fos = false;

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

    local trouble = require("trouble")

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.ispect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space><Enter>', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('v', '<leader>=', vim.lsp.buf.format, { silent = true, buffer = 0 })

    -- Trouble-specific LSP commands
    vim.keymap.set('n', '<leader>t', function() trouble.toggle('document_diagnostics') end, opts) -- document diagnostics
    vim.keymap.set('n', '<leader>T', function() trouble.toggle('workspace_diagnostics') end, opts) -- workspace diagnostics

    -- Handle dynamic "format on save" functionality
    local function supports_format(client)
      if
          client.config
          and client.config.capabilities
          and client.config.capabilities.documentFormattingProvider == false
      then
        return false
      end
      return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
    end

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
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
            for _, client in ipairs(clients) do
              if supports_format(client) then
                vim.lsp.buf.format { async = false }
              end
            end
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
      elseif cmd.args == "off" then
        toggle_format_on_save(false)
      else
        vim.notify("Invalid argument: " .. cmd.args, vim.log.levels.ERROR, {
          title = "LSP",
        });
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

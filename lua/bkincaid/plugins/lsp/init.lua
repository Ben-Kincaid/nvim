local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  priority = 902
}


function M.config()
  -- ## nvim-lspconfig: Setup specific LSP servers ##
  local lspconfig = require('lspconfig')

  -- Rust
  lspconfig.rust_analyzer.setup {
    settings = {
      ['rust-analyzer'] = {

      },
    },
  }

  -- TS/JS
  lspconfig.tsserver.setup {
    settings = {
      diagnostics = {
        ignoredCodes = { 8010, 8002, 8003, 8004, 8005, 8006, 8008, 8009, 8011, 8012, 8013, 8016 }
      }
    }
  }
  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "tsconfig.json",
    callback = function()
      vim.cmd("set filetype=jsonc")
    end
  })

  -- Golang
  lspconfig.gopls.setup {}

  -- PHP
  lspconfig.phpactor.setup {}

  -- Lua
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        }
      }
    }
  }

  -- ESLint
  lspconfig.eslint.setup{}

  -- CSS
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  lspconfig.cssls.setup {
    capabilities = capabilities,
  }

  -- JSON
  lspconfig.jsonls.setup {
    capabilities = capabilities,
  }

  -- HTML
  lspconfig.html.setup {
    capabilities = capabilities,
  }

  -- Svelte
  lspconfig.svelte.setup {}

  -- Scala
  lspconfig.metals.setup {}

  -- Terraform
  lspconfig.terraformls.setup {}

  -- YAML
  lspconfig.yamlls.setup {
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
      },
    }
  }

  -- ## Trigger remaps ##
  require('bkincaid.plugins.lsp.remap')

  -- ## Set up diagnostic config ##
  vim.diagnostic.config({
    severity_sort = true,
    float = {
      focusable = true,
      source = "always",
      header = "",
      border = "rounded"
    },
  })

  -- ## Set hover window overrides
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded"
  })
end

return M

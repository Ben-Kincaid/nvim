local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  priority = 902,
  dependencies = {
    'hrsh7th/nvim-cmp',
  }
}

function M.config()
  -- ## nvim-lspconfig: Setup specific LSP servers ##
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Rust
  lspconfig.rust_analyzer.setup {
    capabilities = capabilities
  }

  -- TS/JS
  lspconfig.tsserver.setup {
    capabilities = capabilities,
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

  -- Astro
  lspconfig.astro.setup{
    capabilities = capabilities
  }

  -- Golang
  lspconfig.gopls.setup {
    capabilities = capabilities,
  }

  -- PHP
  lspconfig.phpactor.setup {
    capabilities = capabilities
  }

  -- Lua
  lspconfig.lua_ls.setup {
    capabilities = capabilities,
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

  -- CSS
  lspconfig.cssls.setup {
    capabilities = capabilities,
  }

  -- Tailwind
  lspconfig.tailwindcss.setup {
    capabilities = capabilities
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
  lspconfig.metals.setup {
    capabilities = capabilities,
  }

  -- Terraform
  lspconfig.terraformls.setup {
    capabilities = capabilities
  }

  -- YAML
  lspconfig.yamlls.setup {
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = {
          ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json"] = "/.github/workflows/*",
        },
      },
    }
  }

  -- Ruby
  lspconfig.solargraph.setup {
    capabilities = capabilities,
  }

  -- Markdown
  lspconfig.marksman.setup {
    capabilities = capabilities,
  }
  lspconfig.mdx_analyzer.setup {
    capabilities = capabilities,
    filetypes = {'mdx'}
  }

  -- OCaml
  lspconfig.ocamllsp.setup {
    capabilities = capabilities,
  }

  -- ESLint
  lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  })

  -- Clang
  lspconfig.clangd.setup {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  }

  -- Elixir
  lspconfig.elixirls.setup {
    capabilities = capabilities,
    cmd = {"~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh"}
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
    },
  })

  -- ## Set hover window overrides
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {})
end

return M

local M = {
  "neovim/nvim-lspconfig",
  commit = "e5bf88e",
  lazy = false,
  priority = 902,
  dependencies = {
    'hrsh7th/nvim-cmp',
    'mfussenegger/nvim-jdtls',
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
  lspconfig.ts_ls.setup {
    capabilities = capabilities,
  }

  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "tsconfig.json",
    callback = function()
      vim.cmd("set filetype=jsonc")
    end
  })

  -- Astro
  lspconfig.astro.setup {
    capabilities = capabilities,
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
          version = 'Lua 5.4',
          path = {
            "?.lua",
            "?/init.lua",
            "/usr/local/share/lua/5.4/?.lua",
          }
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          ignoreSubmodules = false,
          library = {
            -- Get runtime files
            vim.api.nvim_get_runtime_file("", true),
            -- Load love2d lib
            "${3rd}/love2d/library",
            -- Load globally installed luarocks dependencies
            "/usr/local/share/lua/5.1/",
          },
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
    filetypes = { 'mdx' }
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
    cmd = { "~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" }
  }

  -- Flow
  lspconfig.flow.setup {
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern(".flowconfig", "flowconfig")
  }

  -- Biome
  lspconfig.biome.setup {
    capabilities = capabilities,
  }

  -- Teal
  lspconfig.teal_ls.setup {
    capabilities = capabilities,
    filetypes = { "teal" },
    root_dir = lspconfig.util.root_pattern("tlconfig.lua", ".git"),
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

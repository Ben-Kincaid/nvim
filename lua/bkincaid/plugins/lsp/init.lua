local M = {
  -- nvim-lspconfig now only provides server configurations
  -- LSP functionality is built into vim.lsp.config
  "neovim/nvim-lspconfig",
  lazy = false,
  priority = 902,
  dependencies = {
    'hrsh7th/nvim-cmp',
    'mfussenegger/nvim-jdtls',
  }
}

function M.config()
  -- ## vim.lsp.config: Setup specific LSP servers ##
  -- Load server configs from nvim-lspconfig (now just a config provider)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Helper to start LSP client
  local function start_lsp(server_name, config)
    local cfg = vim.tbl_deep_extend('force', {
      name = server_name,
      capabilities = capabilities,
    }, config or {})
    vim.lsp.config(server_name, cfg)
    vim.lsp.enable(server_name)
  end

  -- Rust
  start_lsp('rust_analyzer')

  -- TS/JS
  start_lsp('ts_ls')
  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "tsconfig.json",
    callback = function()
      vim.cmd("set filetype=jsonc")
    end
  })

  -- Astro
  start_lsp('astro')

  -- Golang
  start_lsp('gopls')

  -- PHP
  start_lsp('phpactor')

  -- Lua
  start_lsp('lua_ls', {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        }
      })
    end,
    settings = {
      Lua = {}
    }
  })

  -- CSS
  start_lsp('cssls')

  -- Tailwind
  start_lsp('tailwindcss')

  -- JSON
  start_lsp('jsonls')

  -- HTML
  start_lsp('html')

  -- Svelte
  start_lsp('svelte')

  -- Scala
  start_lsp('metals')

  -- Terraform
  start_lsp('terraformls')

  -- YAML
  start_lsp('yamlls', {
    settings = {
      yaml = {
        schemas = {
          ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json"] =
          "/.github/workflows/*",
        },
      },
    }
  })

  -- Ruby
  start_lsp('solargraph')

  -- Markdown
  start_lsp('marksman')

  start_lsp('mdx_analyzer', {
    filetypes = { 'mdx' }
  })

  -- OCaml
  start_lsp('ocamllsp')

  -- ESLint
  start_lsp('eslint', {
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  })

  -- Clang
  start_lsp('clangd', {
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })

  -- Elixir
  start_lsp('elixirls', {
    cmd = { "~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" }
  })

  -- Flow
  local lspconfig_util = require('lspconfig.util')
  start_lsp('flow', {
    root_dir = lspconfig_util.root_pattern(".flowconfig", "flowconfig")
  })

  -- Biome
  start_lsp('biome')

  -- Teal
  start_lsp('teal_ls', {
    filetypes = { "teal" },
    root_dir = lspconfig_util.root_pattern("tlconfig.lua", ".git"),
  })

  -- GDScript
  start_lsp('gdscript', {
    cmd = { "godot-wsl-lsp", "--useMirroredNetworking", "--experimentalFastPathConversion" },
  })


  -- ## Trigger remaps ##
  require('bkincaid.plugins.lsp.remap')

  -- ## Set up diagnostic config ##
  vim.diagnostic.config({
    severity_sort = true,
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float({ bufnr = bufnr, focusable = true, focus = false })
      end
    }
  })
end

return M

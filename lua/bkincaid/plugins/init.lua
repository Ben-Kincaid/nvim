-- Install lazy.nvim automatically
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Require all plugin configs
local harpoon = require('bkincaid.plugins.harpoon')
local alpha = require('bkincaid.plugins.alpha')
local colorscheme = require('bkincaid.plugins.colorscheme')
local colorizer = require('bkincaid.plugins.colorizer')
local telescope = require('bkincaid.plugins.telescope')
local lualine = require('bkincaid.plugins.lualine')
local bufferline = require('bkincaid.plugins.bufferline')
local treesitter = require('bkincaid.plugins.treesitter')
local oil = require('bkincaid.plugins.oil')
local fugitive = require('bkincaid.plugins.fugitive')
local lsp = require('bkincaid.plugins.lsp')
local mason = require('bkincaid.plugins.mason')
local masonlsp = require('bkincaid.plugins.masonlsp')
local marks = require('bkincaid.plugins.marks')
local luasnip = require('bkincaid.plugins.luasnip');
local cmp = require('bkincaid.plugins.lsp.cmp');
local markdown_preview = require('bkincaid.plugins.markdown_preview')
local notify = require('bkincaid.plugins.notify');
local yuphelp = require('bkincaid.plugins.yuphelp');
local copilot = require('bkincaid.plugins.copilot');
local toggleterm = require('bkincaid.plugins.toggleterm');
local gitsigns = require('bkincaid.plugins.gitsigns');
local treesitter_context = require('bkincaid.plugins.treesitter-context')
local dap = require('bkincaid.plugins.dap')
local dap_js = require('bkincaid.plugins.dap.js')
local dap_go = require('bkincaid.plugins.dap.go')
local dap_ui = require('bkincaid.plugins.dap.ui')
local obsidian = require('bkincaid.plugins.obsidian')
local fmtr = require('bkincaid.plugins.fmtr')
local trouble = require('bkincaid.plugins.trouble')

-- Create table of plugin configs
local plugins = {
  -- Core plugins
  { 'nvim-lua/plenary.nvim' },       -- helper library used by multiple plugins,
  { 'nvim-tree/nvim-web-devicons' }, -- Enhanced font icons

  -- Colors
  colorscheme, -- Setup & define color scheme
  colorizer,   -- Plugin for visualizing hex/rgb colors

  -- Fuzzy finding, grep search, buffer mgmt
  telescope,
  { 'junegunn/fzf',                             build = ":call fzf#install()" },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- Allows us to use fzf as picker for telescope

  -- Status line
  lualine,

  -- Bufferline
  bufferline,

  -- Treesitter
  treesitter,
  treesitter_context,

  -- File Explorer
  oil,

  -- Fugitive (git)
  fugitive,
  { 'tpope/vim-rhubarb' },

  -- LSP (mason for lsp management, mason-lspconfig for integration, nvim-lspconfig for lsp setup)
  mason,
  masonlsp,
  lsp,

  -- Completion
  cmp,

  -- Snippets
  luasnip,


  -- Start screen
  alpha,

  -- Markdown Preview
  markdown_preview,

  -- Marks
  marks,

  -- Notify
  notify,

  -- Help in floating window
  yuphelp,

  -- Copilot
  copilot,

  -- Comments
  { 'tpope/vim-commentary' },

  -- Integrated terminal
  toggleterm,

  -- Git signs
  gitsigns,

  -- Debugger
  dap,
  dap_js,
  dap_go,
  dap_ui,

  -- Obsidian integration
  obsidian,

  -- Formatter
 fmtr,

 -- Trouble (better quickfix lists + lsp diagnostics)
 trouble,

 -- Harpoon
  harpoon
}

-- Initialize lazy with plugins
require("lazy").setup(plugins)

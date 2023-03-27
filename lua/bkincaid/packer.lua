-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Colorscheme
	use { "catppuccin/nvim", as = "catppuccin" }

	-- fzf - Fuzzy finding, grep search, buffer mgmt
	use { 'junegunn/fzf', run = ":call fzf#install()" }
	use { 'ibhagwan/fzf-lua', requires = { 'nvim-tree/nvim-web-devicons' } }

	-- Status line
	use {
		'nvim-lualine/lualine.nvim'
	}

	-- Bufferline
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

	-- Treesitter
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	-- File Explorer
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly'               -- optional, updated every week. (see issue #1193)
	}

	-- Fugitive (git)
	use('tpope/vim-fugitive')

	-- LSP (mason for lsp management, mason-lspconfig for integration, nvim-lspconfig for lsp setup)
	use {
		"williamboman/mason.nvim",
		run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}
	use {
		"williamboman/mason-lspconfig.nvim",
	}
	use {
		"neovim/nvim-lspconfig",
	}

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v<CurrentMajor>.*",
		-- install jsregexp (optional!:).
		run = "make install_jsregexp"
	})

	-- Completion
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'saadparwaiz1/cmp_luasnip' }


	-- Start screen
	use {
		'goolord/alpha-nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require 'alpha'.setup(require 'alpha.themes.startify'.config)
		end
	}

	-- Markdown Preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})

	-- Marks
	use 'toppair/reach.nvim'
	use 'chentoast/marks.nvim'


	-- Surround - Replace surrounding elements
	use "tpope/vim-surround"


	-- Neorg - note taking, organization
	use {
		"nvim-neorg/neorg",
		config = function()
			require('neorg').setup {
				load = {
					["core.defaults"] = {},  -- Loads default behaviour
					["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
					["core.norg.completion"] = { engine = "nvim-cmp" },
					["core.norg.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/neorg-notes",
							},
						},
					},
				},
			}
		end,
		run = ":Neorg sync-parsers",
		requires = "nvim-lua/plenary.nvim",
	}



	-- Help in floating window
	use "Ben-Kincaid/yuphelp.nvim"
end)

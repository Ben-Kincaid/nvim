-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Colorscheme
	use 'sainnhe/everforest'

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
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

	-- Fugitive (git)
	use('tpope/vim-fugitive')

	-- LSP
	use { 'neoclide/coc.nvim', branch = 'release' }
	vim.g.coc_node_path = '/Users/benkincaid/.nvm/versions/node/v18.12.1/bin/node'

	use { 'pangloss/vim-javascript' }
	use { 'maxmellon/vim-jsx-pretty' }

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

	-- Help in floating window
	use "Ben-Kincaid/yuphelp.nvim"
end)

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.clipboard:append("unnamedplus")

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("home" .. "/.vim/undodir")
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.wrap = false

vim.g.editorconfig = true

vim.opt.fillchars:append('eob: ')

-- Automatically set wrap on .md/.txt files
local group = vim.api.nvim_create_augroup("Text File Wrap Settings", { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.md', '*.txt' },
  group = group,
  command = 'setlocal wrap'
})

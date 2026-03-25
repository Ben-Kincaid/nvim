local is_vsc = vim.g.vscode

vim.g.mapleader = " "

-- Save & quit
if is_vsc then
  local vsc = require('vscode')
  -- File commands
  vim.keymap.set("n", "<leader>q", function() vsc.action('workbench.action.closeActiveEditor') end)
  vim.keymap.set("n", "<leader>X", function() vsc.action('workbench.action.closeOtherEditors') end)
  vim.keymap.set("n", "<leader>o", function() vsc.action('workbench.action.quickOpen') end)
  vim.keymap.set("n", "<leader>f", function() vsc.action('workbench.action.findInFiles') end)
  vim.keymap.set("n", "<leader>p", function() vsc.action('workbench.action.showCommands') end)
  vim.keymap.set("n", "<leader>b", function() vsc.action('workbench.action.toggleSidebarVisibility') end)
  vim.keymap.set("n", "<leader><CR>", function() vsc.action('editor.action.formatDocument') end)


  -- vanilla LSP commands
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename)
  vim.keymap.set('n', ']d', function() vsc.action('editor.action.marker.nextInFiles') end)
  vim.keymap.set('n', '[d', function() vsc.action('editor.action.marker.prevInFiles') end)
else
  vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
  vim.keymap.set("n", "<leader>Q", "<cmd>:tabclose<cr>");
  vim.keymap.set("n", "<leader>X", "<cmd>qa!<cr>")
end

vim.keymap.set("n", "<leader>s", "<cmd>w<cr>")

-- Move selection up & down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle when pd/pu
vim.keymap.set("n", "<C-d>", "<C-d>zz");
vim.keymap.set("n", "<C-u>", "<C-u>zz");

-- Keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste in visual while not storing deleted text in register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Use ]b and [b to navigate buffers
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprev<cr>")

-- Close all other splits
vim.keymap.set("n", "<leader>W", "<cmd>only<cr>")

-- Map ctrl-c to esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Replace all instances of cursor word
vim.keymap.set("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

function PushToReg(str)
  vim.cmd('let @+="' .. str .. '"')
  vim.notify('Copied "' .. str .. '"!', vim.log.levels.INFO, { title = "File path copied." })
end

function CopyFile(absolute)
  local path

  -- Determine appropriate path depth
  if absolute then
    path = vim.fn.expand('%:p')
  else
    path = vim.fn.expand("%:.")
  end

  if path == "" then
    vim.notify("No file in current buffer.", vim.log.levels.ERROR, { title = "File path copy failed." })
    return
  end

  -- Add path to registry
  PushToReg(path)
end

-- Copy relative path
vim.keymap.set("n", "<leader>CC", function()
  CopyFile(false);
end)

-- Copy absolute path
vim.keymap.set("n", "<leader>CX", function()
  CopyFile(true);
end)

-- Copy file name
vim.keymap.set("n", "<leader>CF", function()
  local fn = vim.fn.expand('%:t')
  PushToReg(fn);
end)

-- Copy file name + line row
vim.keymap.set("n", "<leader>CL", function()
  local fn = vim.fn.expand('%:t')
  local ln, _ = unpack(vim.api.nvim_win_get_cursor(0))
  PushToReg(fn .. ":" .. ln)
end)

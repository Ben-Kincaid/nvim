-- A minimal version of `init.lua` that can be used by the Neovim VSCode plugin
-- Don't include anything here that requires native UI features, since those won't 
-- work in VSCode's embedded Neovim instance


-- Vim options
require("bkincaid.rules")
-- Generic keymaps
require("bkincaid.remap")

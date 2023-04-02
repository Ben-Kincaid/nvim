-- Initialize native LSP & specific language servers
require("bkincaid.lsp.lsp");
-- Setup key mappings for LSP functionality
require("bkincaid.lsp.remap");
-- Setup autocompletion from LSP & various supported sources
require("bkincaid.lsp.completion");
-- Setup LSP's for languages that don't provide an LSP (i.e. prettier)
require("bkincaid.lsp.null");
-- Setup Mason & related plugins for managing installed language servers
require("bkincaid.lsp.manager");


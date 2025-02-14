local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<leader>T",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>t",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "gi",
      "<cmd>Trouble lsp_implementations toggle focus=true<cr>",
      desc = "LSP Implementations (Trouble)",
    },
    {
      "gd",
      "<cmd>Trouble lsp_definitions toggle focus=true<cr>",
      desc = "LSP Definitions (Trouble)",
    },
    {
      "gr",
      "<cmd>Trouble lsp_references toggle focus=true<cr>",
      desc = "LSP References (Trouble)",
    }
  }
}

return M

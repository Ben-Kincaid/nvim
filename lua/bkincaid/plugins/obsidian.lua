local M = {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre " .. vim.fn.expand "~" .. "/Vaults/NoteJournal/**.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  opts = {
    dir = '~/Vaults/NoteJournal',
    daily_notes = {
      folder = 'daily',
      date_format = '%Y-%m-%d',
    },
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },
  keys = {
    { '<leader>O', '<cmd>ObsidianOpen<CR>',    desc = "Open note in viewer" },
    {
      '<leader>n',
      function()
        vim.ui.input({ prompt = "Note title: " }, function(title)
          vim.cmd("ObsidianNew " .. title)
        end)
      end,
      desc = "Create a new note"
    },
    { '<leader>N', '<cmd>ObsidianToday<CR>',   desc = "Create a new daily note" },
    { '<leader>l', '<cmd>ObsidianLink<CR>',    desc = "Link to existing note",  mode = 'v' },
    { '<leader>L', '<cmd>ObsidianLinkNew<CR>', desc = "Link & create new note", mode = 'v' },
  }
}

function M.config()
  local obs = require("obsidian")
  obs.setup(M.opts)
end

return M

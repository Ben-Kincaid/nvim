local M = {
  'nvim-telescope/telescope.nvim',
  version = '0.1.4',
  dependencies = { { 'nvim-lua/plenary.nvim' } }
}


function M.config()
  local trouble = require('trouble.sources.telescope')
  local builtin = require('telescope.builtin')
  local Path = require "plenary.path"
  local file_dropdown = {
    find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
    results_title = false,
    preview_title = false,
    theme = "dropdown",
    previewer = false,
    path_display = {
      'truncate'
    },
    layout_config = {
      anchor = "N",
      width = 90
    }
  }

  local search_panel = {
    theme = 'ivy',
    path_display = {
      'truncate'
    },
    layout_config = {
      height = 40,
      prompt_position = "top",
    },
  }

  require('telescope').setup {
    pickers = {
      find_files = file_dropdown,
      commands = file_dropdown,
      marks = search_panel,
      live_grep = search_panel,
      help_tags = search_panel,
      buffers = file_dropdown,
      grep_string = search_panel,
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case"
      },
      -- ["google-calendar"] = {
      --   client_id = os.getenv("NVIM_TELESCOPE_GOOGLE_CLIENT_ID"),
      --   client_secret = os.getenv("NVIM_TELESCOPE_GOOGLE_CLIENT_SECRET"),
      --   redirect_uri = "http://127.0.0.1:3456"
      -- }
    },
    defaults = {
      mappings = {
        i = { ["<c-t>"] = trouble.open },
        n = { ["<c-t>"] = trouble.open },
      },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--glob',
        '!**/.git/**'
      },
    }
  }


  -- Find file in cwd
  vim.keymap.set('n', '<leader>o', builtin.find_files, {})
  -- Grep string in cwd
  vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
  -- View help files
  vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
  -- View current buffers
  vim.keymap.set('n', '<leader>`', builtin.buffers, {})
  -- Search current working directory for word under cursor
  vim.keymap.set("n", "<leader>F", builtin.grep_string, {})
  -- View all active marks
  vim.keymap.set("n", "<leader>m", builtin.marks, {})
  -- Open command palette
  vim.keymap.set("n", "<C-p>", builtin.commands, {})
  -- Search in current buffer directory
  vim.keymap.set('n', '<leader>iD', function()
    local bwd = vim.fn.expand("%:p:h")
    local shortened_bwd = Path:new(bwd):make_relative()
    if string.len(bwd) > 60 then
      shortened_bwd = vim.fn.pathshorten(shortened_bwd)
    end
    builtin.live_grep({ cwd = bwd, prompt_title = "Search in directory: " .. shortened_bwd })
  end)
  -- Search in directory relative to project root
  vim.keymap.set('n', '<leader>id', function()
    -- Check if a given path actually exists
    local function exists(file)
      local ok, err = os.rename(file, file)
      return ok, err
    end

    local cwd --- Check if a file or directory exists in this path

    vim.ui.input({
      prompt = 'Search in directory > '
    }, function(input)
      local is_absolute = string.sub(input, 1, 1) == "/"

      if (is_absolute) then
        cwd = input
      else
        cwd = vim.fn.getcwd() .. '/' .. input
      end

      local ok = exists(cwd)

      if ok then
        builtin.live_grep({ cwd = cwd, prompt_title = "Search in directory: " .. cwd })
      else
        vim.notify('"' .. cwd .. '" Does not exist.', vim.log.levels.ERROR, { title = "Search in directory" })
      end
    end)
  end)


  -- Open today's calendar events
  -- vim.keymap.set('n', '<leader>cc', '<cmd>:Telescope google-calendar calendar<cr>')

  -- Explicitly register any extensions
  require('telescope').load_extension('fzf'); -- Use fzf for fuzzy finding
  -- require('telescope').load_extension('google-calendar') -- Display google calendar events as a picker
end

return M

## Ben Kincaid's "Sane" Neovim Config
This repo contains my daily neovim config. It is built to provide a robust programming & text-editing experience that you would expect from any other modern text editor, while not conflating itself with too much IDE-like functionality. It is most efficient with a terminal-based workflow, preferably with the [tmux](https://github.com/tmux/tmux/wiki) session manager.

![](docs/meme.jpg)

#### Core features
- Lazy-loaded plugins via [lazy.nvim](https://github.com/folke/lazy.nvim).
- LSP integration (via [Neovims native LSP](https://neovim.io/doc/user/lsp.html)) with help from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
  - Enhanced with [mason.nvim](https://github.com/williamboman/mason.nvim) for easily managing & installing different language servers.
- Autocomplete via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with a ton of helpful completion sources provided.
- AI-generated code/function suggestions via Github Copilot ([copilot.vim](https://github.com/github/copilot.vim)) 
- Cozy Git integration (via [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) and [vim-fugitive](https://github.com/tpope/vim-fugitive))
  - Manage remote Github issues/PR's via [octo.nvim](https://github.com/pwntester/octo.nvim).
- Performant fuzzy finding & file search via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), enhanced with the [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) for 🔥blazingly🔥 fast performance.
- UI enhancements such as a pretty buffer line ([bufferline.nvim](https://github.com/akinsho/bufferline.nvim)), status line ([lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)), file tree explorer ([nvim-tree.nvim](https://github.com/nvim-tree/nvim-tree.lua)), and cool notifications ([nvim-notify](https://github.com/rcarriga/nvim-notify)). 
- Many more handy plugins (See: [lua/bkincaid/plugins/init.lua](lua/bkincaid/plugins/init.lua) ) & remaps for a general programming & productivity-focused workflow.

#### Directory structure
- `init.lua`: The entrypoint for the neovim config. Requires all core files from `lua/bkincaid`.
- `lua/`: Contains all requireable lua modules/files.
  - `bkincaid/`: All internal lua modules/files.
    - `remap.lua`: General remaps. Any remaps that are not plugin-dependant should be placed here.
    - `rules.lua`: Setting all global [vim options](https://vimdoc.sourceforge.net/htmldoc/options.html)
    - `tmux.lua`: All specific integrations with tmux. Tmux is a core part of my workflow and didn't want to associate this file as a "plugin" as it's a purely external dependency other than the bindings in this file.
    - `plugins/`: Directory which houses all plugin-specific modules & initialization file
      - `init.lua`: Handles initialization of lazy.nvim & definition of all plugins
      - `[plugin].lua`: Individual plugin definition table.

#### Contributions
Since this is my personal configuration, i'm not open to contributions to this repo. However, feel free to fork this repo as a "vanilla" starting point to your own Neovim config, or start a [discussion](https://github.com/Ben-Kincaid/nvim/discussions) if any tips or recommendations in ways to improve the current config. 

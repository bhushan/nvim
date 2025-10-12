# Neovim Configuration

A modern, feature-rich Neovim configuration focused on PHP/Laravel development with excellent support for multiple languages and frameworks.

## Features

- **Modern Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, efficient plugin loading
- **LSP Integration**: Full Language Server Protocol support with auto-completion, diagnostics, and code navigation
- **Smart Fuzzy Finding**: Powerful file and text search with Snacks picker
- **Git Integration**: Inline git blame, hunk operations, and git status in sign column
- **Auto-formatting**: Format-on-save for PHP (Pint), JavaScript/TypeScript (Prettier), Python (Black), Lua (Stylua)
- **Test Runner**: Run tests directly from Neovim for PHPUnit, Jest, pytest, and more
- **Presentations**: Create and present markdown-based slideshows directly in Neovim
- **Tmux Integration**: Seamless navigation between Neovim splits and tmux panes
- **Beautiful UI**: Dracula theme with custom statusline and dashboard

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons (recommended)
- Node.js (for LSP servers and formatters)
- PHP >= 8.0 (for PHP development)

### Optional Dependencies

- `ripgrep` - Fast text searching
- `fd` - Fast file finding
- `prettierd` - Faster JavaScript/TypeScript formatting
- `stylua` - Lua formatting
- `pint` - PHP formatting (Laravel)
- `black` & `isort` - Python formatting

## Installation

1. **Backup existing configuration**:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this repository**:

   ```bash
   git clone <repository-url> ~/.config/nvim
   # Or if using dotfiles structure:
   ln -s ~/code/dotfiles/nvim ~/.config/nvim
   ```

3. **Launch Neovim**:

   ```bash
   nvim
   ```

   Plugins will automatically install on first launch. Wait for all plugins to complete installation.

4. **Install LSP servers**:
   ```vim
   :Mason
   ```
   Press `i` to install servers. Recommended servers:
   - `lua_ls` - Lua
   - `intelephense` or `phpactor` - PHP
   - `ts_ls` - TypeScript/JavaScript
   - `pyright` - Python
   - `html` - HTML
   - `cssls` - CSS

## Structure

```
nvim/
├── init.lua                      # Entry point
├── lua/
│   ├── core/
│   │   ├── options.lua          # Vim options and settings
│   │   ├── keymaps.lua          # Core keybindings
│   │   ├── autocmds.lua         # Autocommands
│   │   └── lazy.lua             # Plugin manager setup
│   └── plugins/
│       ├── init.lua             # Main plugin specifications
│       ├── editor/
│       │   ├── cmp.lua          # Completion configuration
│       │   ├── treesitter.lua   # Syntax highlighting
│       │   ├── autopairs.lua    # Auto-close brackets
│       │   └── present.lua      # Markdown presentations
│       ├── lsp/
│       │   └── lspconfig.lua    # LSP server configurations
│       ├── ui/
│       │   ├── theme.lua        # Dracula colorscheme
│       │   ├── lualine.lua      # Statusline
│       │   └── snacks.lua       # UI components (picker, terminal, etc)
│       ├── git/
│       │   └── gitsigns.lua     # Git integration
│       ├── tools/
│       │   ├── vim-test.lua     # Test runner
│       │   └── which-key.lua    # Keybinding hints
│       └── lang/
│           └── php.lua          # PHP-specific plugins
└── snippets/                     # Custom snippets directory
```

## Key Bindings

### General

| Key           | Mode          | Action                   |
| ------------- | ------------- | ------------------------ |
| `,`           | Normal        | Leader key               |
| `;`           | Normal/Visual | Enter command mode (`:`) |
| `<Esc>`       | Normal        | Clear search highlight   |
| `jj`          | Insert        | Exit insert mode         |
| `<C-h/j/k/l>` | Normal        | Navigate between splits  |
| `<C-w>`       | Normal        | Close current buffer     |

### File Navigation

| Key          | Mode   | Action                              |
| ------------ | ------ | ----------------------------------- |
| `<C-p>`      | Normal | Smart file search (git-aware)       |
| `<C-p><C-p>` | Normal | Search all files (including hidden) |
| `<C-f>`      | Normal | Live grep (search in files)         |
| `\`          | Normal | Toggle file explorer                |
| `<leader>fk` | Normal | Find keymaps                        |
| `<leader>pp` | Normal | Switch projects                     |
| `<leader>tS` | Normal | Show all pickers                    |

### LSP

| Key          | Mode   | Action                   |
| ------------ | ------ | ------------------------ |
| `gd`         | Normal | Go to definition         |
| `gr`         | Normal | Go to references         |
| `gI`         | Normal | Go to implementation     |
| `<leader>rn` | Normal | Rename file              |
| `<leader>d`  | Normal | Show diagnostic message  |
| `[d` / `]d`  | Normal | Previous/next diagnostic |
| `<leader>ls` | Normal | LSP document symbols     |
| `<leader>lS` | Normal | LSP workspace symbols    |
| `K`          | Normal | Hover documentation      |

### Code Actions

| Key         | Mode         | Action               |
| ----------- | ------------ | -------------------- |
| `gcc`       | Normal       | Toggle line comment  |
| `gc`        | Visual       | Toggle comment       |
| `<leader>x` | Normal       | Run code             |
| `<leader>X` | Normal       | Run code (custom)    |
| `<C-e>`     | Normal (PHP) | PHP refactoring menu |

### Git

| Key          | Mode   | Action                 |
| ------------ | ------ | ---------------------- |
| `[h` / `]h`  | Normal | Previous/next git hunk |
| `<leader>hs` | Normal | Stage hunk             |
| `<leader>hr` | Normal | Reset hunk             |
| `<leader>hp` | Normal | Preview hunk           |
| `<leader>hb` | Normal | Blame line             |

### Terminal

| Key          | Mode            | Action                   |
| ------------ | --------------- | ------------------------ |
| `` ` ``      | Normal/Terminal | Toggle floating terminal |
| `<Esc><Esc>` | Terminal        | Exit terminal mode       |

### Testing

| Key          | Mode   | Action           |
| ------------ | ------ | ---------------- |
| `<leader>tn` | Normal | Run nearest test |
| `<leader>tf` | Normal | Run test file    |
| `<leader>ts` | Normal | Run test suite   |
| `<leader>tl` | Normal | Run last test    |

### Presentations

| Key         | Mode         | Action                                   |
| ----------- | ------------ | ---------------------------------------- |
| `<leader>c` | Normal       | Toggle presentation (start/pause/resume) |
| `n`         | Presentation | Next slide                               |
| `p`         | Presentation | Previous slide                           |
| `<leader>c` | Presentation | Pause presentation (toggle to edit)      |
| `q`         | Presentation | Close presentation                       |

### Terraform (if working with .tf files)

| Key          | Mode   | Action                        |
| ------------ | ------ | ----------------------------- |
| `<leader>ti` | Normal | Terraform init                |
| `<leader>tv` | Normal | Terraform validate            |
| `<leader>tp` | Normal | Terraform plan                |
| `<leader>ta` | Normal | Terraform apply               |
| `<leader>tA` | Normal | Terraform apply -auto-approve |

### Visual Mode

| Key       | Mode   | Action                              |
| --------- | ------ | ----------------------------------- |
| `<` / `>` | Visual | Indent/dedent (keeps selection)     |
| `p`       | Visual | Paste without yanking replaced text |
| `y`       | Visual | Yank without moving cursor          |

## Plugin Highlights

### Core Plugins

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Fast plugin manager with lazy loading
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[Mason](https://github.com/williamboman/mason.nvim)** - LSP/formatter/linter installer
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Auto-completion engine
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Collection of UI utilities (picker, terminal, dashboard, etc)

### Editing Enhancement

- **[vim-surround](https://github.com/tpope/vim-surround)** - Surround text objects
- **[vim-unimpaired](https://github.com/tpope/vim-unimpaired)** - Bracket mappings
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Auto-formatting
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close brackets
- **[present.nvim](https://github.com/bhushan/present.nvim)** - Markdown-based presentations

### Git Integration

- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations and operations

### UI/Theme

- **[dracula.nvim](https://github.com/Mofiqul/dracula.nvim)** - Dracula color scheme
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Statusline
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding hints

### Language-Specific

- **[phprefactoring.nvim](https://github.com/bhushan/phprefactoring.nvim)** - PHP refactoring tools
- **[vim-test](https://github.com/vim-test/vim-test)** - Test runner for multiple languages
- **[coderunner.nvim](https://github.com/bhushan/coderunner.nvim)** - Quick code execution

### Utilities

- **[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)** - Tmux integration
- **[vim-heritage](https://github.com/jessarcher/vim-heritage)** - Auto-create parent directories
- **[vim-pasta](https://github.com/sickill/vim-pasta)** - Context-aware paste

## Configuration Highlights

### Editor Settings

- **Leader key**: `,` (comma)
- **Indentation**: 4 spaces (PSR-12 compliant for PHP)
- **Line numbers**: Enabled
- **Sign column**: Always visible (width: 2)
- **Clipboard**: Synced with system clipboard
- **Undo**: Persistent across sessions
- **Backup**: Enabled (stored outside current directory)
- **Update time**: 250ms (faster diagnostics)
- **Scroll offset**: 8 lines (maintains context)

### Auto-formatting

Format-on-save is enabled for:

- **PHP**: Pint (Laravel Pint)
- **JavaScript/TypeScript**: Prettier/Prettierd
- **Python**: Black + isort
- **Lua**: Stylua
- **Vue/HTML/CSS/JSON/YAML**: Prettier/Prettierd

### LSP Features

- Auto-completion with intelligent suggestions
- Inline diagnostics with custom icons
- Hover documentation
- Go to definition/references/implementation
- Signature help
- Code actions
- Rename refactoring
- Document/workspace symbols

## Customization

### Changing Theme

Edit `lua/plugins/ui/theme.lua`:

```lua
return {
  'your-theme/repo',
  init = function()
    vim.cmd.colorscheme 'your-theme'
  end,
}
```

### Adding Custom Keybindings

Add to `lua/core/keymaps.lua`:

```lua
vim.keymap.set('n', '<leader>custom', ':YourCommand<CR>', { desc = 'Description' })
```

### Installing Additional LSP Servers

1. Open Mason: `:Mason`
2. Search for server: `/server-name`
3. Press `i` to install
4. Configure in `lua/plugins/lsp/lspconfig.lua` if needed

### Adding Custom Snippets

Create snippet files in `~/.config/nvim/snippets/` directory using snipmate format.

## Troubleshooting

### Plugins not loading

```vim
:Lazy sync
```

### LSP not working

```vim
:LspInfo          " Check LSP status
:Mason            " Verify servers are installed
```

### Formatters not working

```vim
:ConformInfo      " Check formatter status
```

### Update all plugins

```vim
:Lazy update
```

### Clean and reinstall

```bash
rm -rf ~/.local/share/nvim/lazy
nvim  # Will reinstall all plugins
```

## Performance

This configuration is optimized for performance:

- Lazy loading of plugins
- Event-based plugin initialization
- Fast startup time (~50-100ms)
- Efficient LSP and Tree-sitter usage

## Credits

Configuration maintained by [@rb](https://github.com/rb)

Inspired by:

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- Various community configurations

## License

MIT License - Feel free to use and modify as needed.

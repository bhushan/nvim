# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modern Neovim configuration using lazy.nvim for plugin management. The configuration is optimized for PHP/Laravel development with comprehensive support for JavaScript/TypeScript, Python, and Lua. It emphasizes performance through lazy loading and modular organization.

## Architecture

## Code Style

- always update claude.md

### Bootstrap Sequence

The init system follows a strict load order:

1. `init.lua` - Entry point that loads core modules in sequence
2. `core/options.lua` - Editor settings (must load first)
3. `core/keymaps.lua` - Global keybindings
4. `core/autocmds.lua` - Autocommands
5. `core/lazy.lua` - Plugin manager bootstrap and initialization
6. `core/colors.lua` - Catppuccin Mocha color palette (loaded by UI plugins)

### Plugin Organization

Plugins are organized in `lua/plugins/` with a modular import pattern:

**Main Plugin Registry** (`lua/plugins/init.lua`):

- Simple plugins with inline configuration
- Import statements for complex plugins using `{ import = 'plugins.category.name' }`
- All plugin specs are combined into a single table

**Category Subdirectories**:

- `editor/` - Editing enhancements (completion, treesitter, autopairs, presentations)
- `ui/` - Visual components (theme, statusline, snacks utilities)
- `lsp/` - Language Server Protocol configuration
- `git/` - Git integration (gitsigns)
- `tools/` - Utilities (which-key, vim-test)
- `lang/` - Language-specific plugins (PHP refactoring)

**Key Architectural Pattern**:

```lua
-- In plugins/init.lua
{ import = 'plugins.editor.cmp' }  -- Loads lua/plugins/editor/cmp.lua
{ import = 'plugins.editor.treesitter' }  -- Loads treesitter config

-- In plugins/editor/cmp.lua or treesitter.lua
return { ... plugin spec ... }  -- Must return a plugin spec table
```

### LSP Configuration Architecture

LSP setup in `lua/plugins/lsp/lspconfig.lua` follows this flow:

1. **LspAttach autocommand** - Sets up buffer-local keymaps when LSP attaches
2. **Capabilities** - Enhanced with nvim-cmp for autocompletion
3. **Server definitions** - Table of server-specific configurations
4. **Mason setup** - Automatic LSP server installation
5. **Mason handlers** - Applies server configs with capability merging

**Server Configuration Pattern**:

```lua
local servers = {
  server_name = {
    settings = { ... },
    on_attach = function(client, bufnr) ... end,
  }
}
```

### Snacks.nvim Integration

Snacks provides multiple UI utilities configured in `lua/plugins/ui/snacks.lua`:

- **Dashboard** - Startup screen with ASCII art
- **Picker** - Fuzzy finder (replaces telescope)
- **Terminal** - Floating terminal
- **Explorer** - File tree navigation
- **Notifier** - Notification system
- **Root detection** - Auto-change to project root on VimEnter

Snacks has complex autocmd-based initialization to avoid performance issues.

## Common Development Tasks

### Adding a New Plugin

1. **Simple plugins** (no config needed):

```lua
-- Add to lua/plugins/init.lua
{ 'author/plugin-name' }
```

2. **Plugins with inline config**:

```lua
-- Add to lua/plugins/init.lua
{
  'author/plugin-name',
  opts = { ... },
  keys = { ... },
}
```

3. **Complex plugins** (separate file):

```lua
-- Add to lua/plugins/init.lua
{ import = 'plugins.category.pluginname' }

-- Create lua/plugins/category/pluginname.lua
return {
  'author/plugin-name',
  config = function()
    require('plugin-name').setup({ ... })
  end,
}
```

### Configuring LSP Servers

1. **Add server to configuration** in `lua/plugins/lsp/lspconfig.lua`:

```lua
local servers = {
  server_name = {
    settings = {
      -- Server-specific settings
    },
  }
}
```

2. **Add to ensure_installed list**:

```lua
vim.list_extend(ensure_installed, {
  'server_name',
})
```

3. Mason will automatically install the server on next startup.

### Adding Custom Keybindings

**Global keybindings**: Add to `lua/core/keymaps.lua`

**LSP keybindings**: Add to LspAttach callback in `lua/plugins/lsp/lspconfig.lua`

**Plugin-specific keybindings**: Define in plugin spec using `keys` field or in plugin's config function

### Formatting Configuration

Format-on-save is handled by conform.nvim in `lua/plugins/init.lua`. To add a new formatter:

```lua
formatters_by_ft = {
  filetype = { 'formatter_name' },
}
```

Formatters must be installed via Mason or system package manager.

## Testing

Tests are run via vim-test integration. The configuration automatically detects the test framework:

- PHP: Uses PHPUnit (looks for phpunit.xml or vendor/bin/phpunit)
- JavaScript: Uses Jest (looks for package.json with jest)
- Python: Uses pytest (looks for pytest.ini or pyproject.toml)

**Keybindings**:

- `<C-t>` - Run nearest test (test under cursor)
- `<C-S-t>` - Run last test
- `<Leader>rf` - Run entire test file
- `<Leader>rs` - Run full test suite

## File Type Detection

Blade templates (Laravel) are detected via `ftdetect/blade.lua`, which sets filetype to `blade` for `*.blade.php` files.

## Tree-sitter Configuration

Tree-sitter is configured in `lua/plugins/editor/treesitter.lua` using the native Neovim 0.11+ API.

- Highlighting, indentation, and folding enabled per-filetype via autocmd
- Parsers installed manually via `:TSInstall <lang>` (not on startup)
- `build = ':TSUpdate'` updates parsers when plugin updates

**Commands**:

- `:TSInstall <lang>` - Install a parser
- `:TSUpdate` - Update all parsers

## Performance Considerations

- Plugins use lazy loading with `event`, `ft`, `cmd`, or `keys` triggers
- Heavy plugins load on `VeryLazy` or specific file types
- Snacks features are initialized in VimEnter autocmd to avoid blocking startup
- Tree-sitter parsers are NOT installed on startup (manual `:TSInstall` required)
- LSP servers only attach to relevant file types

## Formatting Code

To format Lua code in this configuration:

```bash
stylua .
```

Configuration is in `stylua.toml` (2 spaces, 120 column width).

## Important Settings

- **Leader key**: `,` (comma)
- **Indentation**: 4 spaces (PHP PSR-12 compliant)
- **Clipboard**: Synced with system
- **Sign column**: Always visible, width 2
- **Update time**: 250ms (faster LSP diagnostics)
- **Relative line numbers**: Enabled
- **Auto-format on save**: Enabled with 500ms timeout
- **Theme**: Catppuccin Mocha (`catppuccin` via `catppuccin/nvim`)

## Theme Configuration

The colorscheme uses **Catppuccin Mocha** from `catppuccin/nvim`. Configuration is in `lua/plugins/ui/theme.lua` with integrations enabled for: cmp, gitsigns, treesitter, notify, mason, which_key, snacks, and native_lsp.

### Shared Color Palette

All UI plugins use the centralized color palette defined in `lua/core/colors.lua`:

- **Lualine** (`lua/plugins/ui/lualine.lua`) - Custom statusline theme
- **Snacks** (`lua/plugins/ui/snacks.lua`) - Explorer and picker highlights

This ensures consistent theming across all plugins. When adding new UI customizations, import colors from `core.colors`:

```lua
local colors = require 'core.colors'
vim.api.nvim_set_hl(0, 'MyHighlight', { fg = colors.blue, bg = colors.base })
```

See `../colors/catppuccin-mocha.md` for the complete color palette used across all dotfiles.

## PHP/Laravel-Specific Features

- **Laravel Pint** - PHP formatter (format-on-save enabled)
- **Intelephense** - Primary PHP LSP with extensive Laravel stubs (includes redis, imagick, memcached)
- **PHP Refactoring** (`<C-e>` in PHP files) - Extract method/variable, rename, change signature
- **Blade syntax** - Laravel Blade template support
- **Composer integration** - Auto-loads vendor directories
- **Tailwind CSS** - Class completion in Blade/PHP files

## JavaScript/TypeScript Features

- **vtsls** - TypeScript/JavaScript LSP with full inlay hints
- **Organize imports on save** - Automatically organizes imports when saving TS/JS files
- **Tailwind CSS** - Class completion with cva/cx regex support
- **CSS LSP** - CSS/SCSS validation and completion
- **ESLint** - Auto-fix on save

## Diagnostics & Code Quality

- **trouble.nvim** - Better diagnostics panel with pretty UI
  - `<leader>xx` - Toggle diagnostics panel
  - `<leader>xX` - Buffer diagnostics only
  - `<leader>xq` - Quickfix in Trouble
- **todo-comments.nvim** - Highlights TODO/FIXME/HACK comments
  - `]t` / `[t` - Jump to next/prev TODO
  - `<leader>ft` - Find all TODOs in project

## Custom Plugins

This configuration uses several custom plugins by the author:

- **coderunner.nvim** - Execute code snippets (`<leader>x`)
- **present.nvim** - Markdown presentations (`<leader>c` to toggle)
- **phprefactoring.nvim** - PHP refactoring toolkit

These are maintained separately and updated via lazy.nvim's plugin update mechanism.

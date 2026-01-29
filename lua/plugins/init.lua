--- Main plugin specifications
--- Centralized plugin configuration using lazy.nvim
--- Organizes plugins by category: editor, UI, LSP, language-specific, tools
--- @module plugins

return {
  -- Simple plugins that don't need configuration files

  --- Surround text objects with quotes, brackets, tags
  --- Provides mappings like ys, cs, ds for quick text wrapping
  --- Examples: ysiw" (wrap word in quotes), cs"' (change " to ')
  { 'tpope/vim-surround' },

  --- Bracket mappings for common operations
  --- Adds pairs of handy bracket mappings like ]b, [b for buffer navigation
  --- [q/]q for quickfix, [a/]a for args, and many more
  { 'tpope/vim-unimpaired' },

  --- Automatically create parent directories when saving files
  --- Prevents "directory does not exist" errors during file save
  { 'jessarcher/vim-heritage' },

  --- Context-aware paste with auto-indentation
  --- Intelligently adjusts indentation when pasting code blocks
  { 'sickill/vim-pasta' },

  --- Fast and extensible commenting
  --- Toggle comments with gcc (line) or gc (visual mode)
  --- Language-aware comment styles via Tree-sitter
  { 'numToStr/Comment.nvim', opts = {} },

  --- Seamless tmux and Neovim split navigation
  --- Use Ctrl+hjkl to navigate between vim splits and tmux panes
  { 'christoomey/vim-tmux-navigator' },

  --- Auto-formatting engine with multiple formatter support
  --- Format on save with fallback chain (e.g., prettierd → prettier)
  --- Configured for PHP (Pint), Lua (Stylua), JS/TS (Prettier), Python (Black)
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        php = { 'pint' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        vue = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    },
  },

  --- Completion engine with snippet support
  --- Provides intelligent autocomplete from LSP, buffer, path, and snippets
  --- Integrates with LuaSnip for snippet expansion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      --- Snippet engine with regex support
      --- Loads snippets from snipmate format
      --- Custom snippets directory: ~/.config/nvim/snippets
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        config = function()
          require('luasnip.loaders.from_snipmate').lazy_load()
          require('luasnip.loaders.from_snipmate').lazy_load {
            paths = { vim.fn.stdpath 'config' .. '/snippets' },
          }
        end,
      },
      'saadparwaiz1/cmp_luasnip', --- LuaSnip completion source
      'hrsh7th/cmp-nvim-lsp', --- LSP completion source
      'hrsh7th/cmp-path', --- File path completion
      'hrsh7th/cmp-buffer', --- Buffer text completion
    },
    config = function()
      require 'plugins/editor/cmp'
    end,
  },

  --- Language Server Protocol configuration
  --- Provides code intelligence: diagnostics, completion, hover, go-to-definition
  --- Auto-installs language servers via Mason
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      --- LSP and tool installer with UI
      --- Manages language servers, formatters, and linters
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      --- Lua language server enhancement for Neovim config
      --- Provides completion and docs for vim.* APIs
      --- Includes type definitions for Neovim runtime
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      --- Luv (libuv) type definitions for async operations
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
      require 'plugins/lsp/lspconfig'
    end,
  },

  --- Syntax highlighting and code parsing engine
  --- Provides fast, accurate syntax highlighting and code structure
  --- Enables advanced features like text objects and refactoring
  { import = 'plugins.editor.treesitter' },

  --- Icon set for file types and UI elements
  --- Required by file explorers, statusline, and other UI plugins
  { 'nvim-tree/nvim-web-devicons' },

  --- Collection of useful UI and utility plugins
  --- Includes: terminal, notifications, bufferline, dashboard, and more
  --- Modern floating terminal with custom commands
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'plugins/ui/snacks'
    end,
  },

  --- Git integration with inline blame and hunk operations
  --- Shows git status in sign column, provides staging/unstaging hunks
  --- Inline blame, diff view, and navigation between changes
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins/git/gitsigns'
    end,
  },

  --- Test runner integration
  --- Run tests from within Neovim for multiple frameworks
  --- Supports PHPUnit, Jest, pytest, RSpec, and more
  {
    'vim-test/vim-test',
    config = function()
      vim.keymap.set('n', '<C-t>', ':TestNearest<CR>', { desc = '[R]un [n]earest test' })
      vim.keymap.set('n', '<C-S-t>', ':TestLast<CR>', { desc = '[R]un [l]ast test' })
      vim.keymap.set('n', '<Leader>rf', ':TestFile<CR>', { desc = '[R]un test [f]ile' })
      vim.keymap.set('n', '<Leader>rs', ':TestSuite<CR>', { desc = '[R]un test [s]uite' })
      vim.keymap.set('n', '<Leader>rv', ':TestVisit<CR>', { desc = '[R]un [v]isit test' })
    end,
  },

  --- Fast and customizable statusline
  --- Displays mode, file info, git status, LSP diagnostics, location
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'plugins/ui/lualine'
    end,
  },

  --- Keybinding popup and documentation
  --- Shows available keybindings in a popup when you start typing
  --- Leader key guide with descriptions for all mappings
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require 'plugins/tools/which-key'
    end,
  },

  -- execute code fastly
  {
    'bhushan/coderunner.nvim',
    dependencies = {
      'folke/snacks.nvim', -- Optional
    },
    config = function()
      require('coderunner').setup {
        languages = {
          markdown = { cmd = 'PresentStart', strategy = 'inline', description = 'Start markdown files in presentation mode' },
        },
      }
    end,
    keys = {
      { '<leader>x', '<cmd>CodeRun<cr>', desc = 'Run Code' },
      { '<leader>X', '<cmd>CodeRunCustom<cr>', desc = 'Run Code (Custom)' },
      { '<leader>xl', '<cmd>CodeRunList<cr>', desc = 'List Languages' },
    },
  },

  --- Auto-close and auto-pair brackets, quotes, tags
  { import = 'plugins.editor.autopairs' },

  --- Present markdown files as slides
  { import = 'plugins.editor.present' },

  --- Colorscheme configuration
  { import = 'plugins.ui.theme' },

  --- PHP-specific tooling and enhancements
  { import = 'plugins.lang.php' },

  --- Better diagnostics panel
  --- Provides a pretty list for diagnostics, quickfix, and location lists
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Trouble' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix (Trouble)' },
    },
    opts = {},
  },

  --- TODO/FIXME comment highlighting and navigation
  --- Highlights TODO, FIXME, HACK, etc. comments with distinct colors
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next TODO',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous TODO',
      },
      { '<leader>ft', '<cmd>TodoTrouble<cr>', desc = 'Find TODOs' },
    },
    opts = {},
  },
}

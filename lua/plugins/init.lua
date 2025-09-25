-- Main plugin specifications
-- This file loads all plugin configurations from organized subdirectories

return {
  -- Simple plugins that don't need configuration files
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
  { 'jessarcher/vim-heritage' },
  { 'sickill/vim-pasta' },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'christoomey/vim-tmux-navigator' },

  -- Enhanced text objects for faster navigation
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  -- Auto-formatting and linting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        php = { 'pint' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        vue = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        scss = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        yaml = { { 'prettierd', 'prettier' } },
        markdown = { { 'prettierd', 'prettier' } },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
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
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      require 'plugins/editor/cmp'
    end,
  },

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
      require 'plugins/lsp/lspconfig'
    end,
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins/editor/treesitter'
    end,
  },

  -- File icons for explorer and other plugins
  { 'nvim-tree/nvim-web-devicons' },

  -- Snacks.nvim - Collection of useful plugins
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'plugins/ui/snacks'
    end,
  },

  -- Git integration.
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins/git/gitsigns'
    end,
  },

  -- test helpers
  {
    'vim-test/vim-test',
    config = function()
      require 'plugins/tools/vim-test'
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'plugins/ui/lualine'
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require 'plugins/tools/which-key'
    end,
  },

  -- Load plugin groups
  { import = 'plugins.editor.autopairs' },
  { import = 'plugins.ui.theme' },
  { import = 'plugins.lang.php' },
}

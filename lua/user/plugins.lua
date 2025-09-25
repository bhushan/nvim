-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

-- TIP: `opts = {}` is the same as calling `require('fidget').setup({})`

require('lazy').setup({
  -- Add, change, and delete surrounding text.
  { 'tpope/vim-surround' },

  -- Pairs of handy bracket mappings, like [b and ]b.
  { 'tpope/vim-unimpaired' },

  -- Automatically create parent dirs when saving.
  { 'jessarcher/vim-heritage' },

  -- Package.json script runner
  {
    'vuki656/package-info.nvim',
    ft = 'json',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      require('package-info').setup()
    end,
  },

  -- Better auto-pairs for faster typing
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },

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

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require 'user/plugins/which-key'
    end,
  },

  -- paste items with correct indentation
  { 'sickill/vim-pasta' },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'user/plugins/treesitter'
    end,
  },

  -- Snacks.nvim - Collection of useful plugins
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require 'user/plugins/snacks'
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
      require 'user/plugins/lspconfig'
    end,
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
      require 'user/plugins/cmp'
    end,
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Project Configuration
  {
    'tpope/vim-projectionist',
    dependencies = { 'tpope/vim-dispatch' },
    config = function()
      require 'user/plugins/projectionist'
    end,
  },

  -- Git integration.
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'user/plugins/gitsigns'
    end,
  },

  -- Navigate seamlessly between Vim windows and Tmux panes.
  { 'christoomey/vim-tmux-navigator' },

  -- test helpers
  {
    'vim-test/vim-test',
    config = function()
      require 'user/plugins/vim-test'
    end,
  },

  -- Show key press while streaming
  {
    'nvchad/showkeys',
    cmd = 'ShowkeysToggle',
    opts = {
      timeout = 1,
      maxkeys = 6,
      -- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
      position = 'bottom-right',
    },

    keys = {
      {
        '<leader>ut',
        function()
          vim.cmd 'ShowkeysToggle'
        end,
        desc = 'Show key presses',
      },
    },
  },

  -- dracula theme
  {
    'Mofiqul/dracula.nvim',
    init = function()
      vim.cmd.colorscheme 'dracula'
    end,
  },

  -- Laravel IDE PHPstorm plugin like support
  {
    'adibhanna/laravel.nvim',
    enabled = false,
    -- dir = "~/Developer/opensource/laravel.nvim",
    ft = { 'php', 'blade' },
    dependencies = {
      'folke/snacks.nvim', -- Optional: for enhanced UI
    },
    config = function()
      require('laravel').setup {
        notifications = false,
        debug = false,
        keymaps = true,
      }
    end,
  },

  -- refactoring capabilities
  {
    'adibhanna/phprefactoring.nvim',
    enabled = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    ft = 'php',
    config = function()
      require('phprefactoring').setup()
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'user/plugins/lualine'
    end,
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

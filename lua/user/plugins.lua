local fn = vim.fn
local standard_path = fn.stdpath("data")
local install_path = standard_path .. "/site/pack/packer/start/packer.nvim"

local ensure_packer = function()
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

    print("Installing packer close and reopen Neovim...")

    vim.api.nvim_command("packadd packer.nvim")

    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").reset()

require("packer").init({
  compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "solid" })
    end,
  },
})

local use = require("packer").use

-- Packer can manage itself.
use("wbthomason/packer.nvim")

-- Commenting support.
use("tpope/vim-commentary")

-- Add, change, and delete surrounding text.
use("tpope/vim-surround")

-- Useful commands like :Rename and :SudoWrite.
use("tpope/vim-eunuch")

-- Pairs of handy bracket mappings, like [b and ]b.
use("tpope/vim-unimpaired")

-- Allow plugins to enable repeating of commands.
use("tpope/vim-repeat")

-- Add more languages.
use("sheerun/vim-polyglot")

-- Navigate seamlessly between Vim windows and Tmux panes.
use("christoomey/vim-tmux-navigator")

-- Automatically create parent dirs when saving.
use("jessarcher/vim-heritage")

-- Automatically set the working directory to the project root.
use({
  "airblade/vim-rooter",
  setup = function()
    -- Instead of this running every time we open a file, we'll just run it once when neovim starts.
    vim.g.rooter_manual_only = 1
  end,
  config = function()
    vim.cmd("Rooter")
  end,
})

-- Add smooth scrolling to avoid jarring jumps
use({
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup()
  end,
})

-- split arrays and objects with gJ gS
use({
  "AndrewRadev/splitjoin.vim",
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

-- paste items with correct indentation
use("sickill/vim-pasta")

-- Fuzzy finder
use({
  "nvim-telescope/telescope.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-telescope/telescope-live-grep-args.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      cond = vim.fn.executable("make") == 1,
      run = "make",
    },
  },
  config = function()
    require("user/plugins/telescope")
  end,
})

-- File tree sidebar
use({
  "kyazdani42/nvim-tree.lua",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("user/plugins/nvim-tree")
  end,
})

-- Display indentation lines.
use({
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("user/plugins/indent-blankline")
  end,
})

-- Git integration.
use({
  "lewis6991/gitsigns.nvim",
  config = function()
    require("user/plugins/gitsigns")
  end,
})

-- Floating terminal.
use({
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.keymap.set("n", "<Leader>`", ":FloatermToggle<CR>")
    vim.keymap.set("t", "<Leader>`", "<C-\\><C-n>:FloatermToggle<CR>")
    vim.cmd([[
      highlight link Floaterm CursorLine
      highlight link FloatermBorder CursorLineBg
    ]])
  end,
})

-- Improved syntax highlighting
use({
  "nvim-treesitter/nvim-treesitter",
  run = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  config = function()
    require("user/plugins/treesitter")
  end,
})

-- context based commenting good in vue, auto integrates with tpope/commentary
use({
  "JoosepAlviste/nvim-ts-context-commentstring",
  after = "nvim-treesitter",
  requires = "nvim-treesitter/nvim-treesitter",
})

-- add support for function and class selection
use({
  "nvim-treesitter/nvim-treesitter-textobjects",
  after = "nvim-treesitter",
  requires = "nvim-treesitter/nvim-treesitter",
})

-- Automatically add closing brackets, quotes, etc.
use({
  "windwp/nvim-autopairs",
  after = "nvim-treesitter",
  requires = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-autopairs").setup({ check_ts = true, disable_in_macro = true })
  end,
})

-- Language Server Protocol.
use({
  "neovim/nvim-lspconfig",
  requires = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    require("user/plugins/lspconfig")
  end,
})

-- Auto Completion Support, integrates with LSP
use({
  "hrsh7th/nvim-cmp",
  requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    -- "hrsh7th/cmp-buffer",
    -- "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
  },
  config = function()
    require("user/plugins/cmp")
  end,
})

-- PHP Refactoring Tools
use({
  "phpactor/phpactor",
  ft = "php",
  run = "composer install --no-dev --optimize-autoloader",
  config = function()
    vim.keymap.set("n", "<Leader>pm", ":PhpactorContextMenu<CR>")
    vim.keymap.set("n", "<Leader>pn", ":PhpactorClassNew<CR>")
  end,
})

-- Project Configuration.
use({
  "tpope/vim-projectionist",
  requires = "tpope/vim-dispatch",
  config = function()
    require("user/plugins/projectionist")
  end,
})

-- Testing helper
use({
  "vim-test/vim-test",
  config = function()
    require("user/plugins/vim-test")
  end,
})

-- choice of theme
use({
  "jesseleite/nvim-noirbuddy",
  requires = { "tjdevries/colorbuddy.nvim", branch = "dev" },
  config = function()
    require("user/plugins/theme")
  end,
})

-- show used colors in code
use({
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
})

-- -- A Status line.
use({
  "nvim-lualine/lualine.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("user/plugins/lualine")
  end,
})

-- Display buffers as tabs.
use({
  "akinsho/bufferline.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  after = "nvim-noirbuddy",
  config = function()
    require("user/plugins/bufferline")
  end,
})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
  require("packer").sync()
end

-- Autocommand that reloads neovim whenever you save any plugins.lua file
local packer_group = vim.api.nvim_create_augroup("packer_group", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
  group = packer_group,
  pattern = "plugins.lua",
  -- pattern = vim.fn.expand("$MYVIMRC"),
})

-- highlight text when yanked, dont need this but lets try for few days
local highlight_group = vim.api.nvim_create_augroup("highlight_group", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

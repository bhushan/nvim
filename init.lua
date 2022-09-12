local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  print("Installing packer close and reopen Neovim...")

  vim.api.nvim_command("packadd packer.nvim")
end

-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Autocommand that reloads neovim whenever you save the init.lua file
-- local packer_group = vim.api.nvim_create_augroup("packer_group", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   command = "source <afile> | PackerSync",
--   group = packer_group,
--   pattern = "init.lua",
-- })

-- Show packer messages in a popup. Looks cooler
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({
        border = "rounded",
      })
    end,
  },
})

-- Alt installation of packer without a function
packer.reset()

local use = packer.use

-- packer can manage itself
use("wbthomason/packer.nvim")

-- better syntax highlighting and parsing
use({
  "nvim-treesitter/nvim-treesitter",
  requires = {
    "p00f/nvim-ts-rainbow", -- colorise matching brackets
    {
      "windwp/nvim-autopairs", -- auto complete brackets
      config = function()
        require("nvim-autopairs").setup({
          check_ts = true,
          disable_in_macro = true,
        })
      end,
    },
  },
  run = ":TSUpdate",
})

-- file formatter same as prettier but with extra file types
use("sbdchd/neoformat")

-- better commenting using treesitter
use("numToStr/Comment.nvim")

-- extra surrounding keybindings
use("tpope/vim-surround")

-- awesome status line
use({
  "nvim-lualine/lualine.nvim",
  requires = {
    "kyazdani42/nvim-web-devicons",
  },
})

-- easily fuzzy file search
use({
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/plenary.nvim" }, -- cmp is needed to show dropdown
    { "nvim-telescope/telescope-project.nvim" }, -- extension for project switching
    {
      "nvim-telescope/telescope-fzf-native.nvim", -- use fzf for quick search
      run = "make",
    },
    { "nvim-telescope/telescope-file-browser.nvim" }, -- file browser
  },
})

-- better navigation to and from nvim to tmux
-- use("christoomey/vim-tmux-navigator")

-- better navigation to and from nvim to kitty
use("knubie/vim-kitty-navigator")

use({
  "L3MON4D3/LuaSnip", -- create cool new snippets
  requires = {
    { "hrsh7th/nvim-cmp" }, -- cmp is needed to show dropdown
    {
      "hrsh7th/cmp-nvim-lsp",
      requires = {
        "neovim/nvim-lspconfig", -- lspconfigs for setting up lsp
        "williamboman/nvim-lsp-installer", -- lsp installer to install lsp servers
      },
    }, -- cmp source to hook into lsp
    { "hrsh7th/cmp-nvim-lua" }, -- cmp source for nvim lua api
    { "saadparwaiz1/cmp_luasnip" }, -- needed for auto completion and auto imports in combination with LuaSnip
    { "hrsh7th/cmp-path" }, -- cmp source path
    { "hrsh7th/cmp-buffer" }, -- cmp source buffer
    { "hrsh7th/cmp-cmdline" }, -- cmp source cmdline
    { "octaltree/cmp-look" }, -- cmp source dictionary lookup
    {
      "rafamadriz/friendly-snippets", -- add user friendly snippets
      config = function()
        require("luasnip/loaders/from_vscode").load({
          paths = {
            "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
          },
        })
      end,
    },
  },
})

-- git gutter
use("lewis6991/gitsigns.nvim")

-- integrate lazygit
use("kdheepak/lazygit.nvim")

-- Better keybindings management and shows hints
use("folke/which-key.nvim")

-- Zend mode hightlighting block of code using treesitter
use("folke/twilight.nvim")

-- DAP
use({
  "mfussenegger/nvim-dap",
  requires = {
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup()
      end,
    },
    { "rcarriga/nvim-dap-ui" },
  },
  run = function()
    local installation_dir = vim.fn.stdpath("data") .. "/dap/vscode-node-debug2"

    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/microsoft/vscode-node-debug2",
      installation_dir,
    })
    fn.system({ "npm", "install", "--prefix", installation_dir })
    fn.system({ "npm", "run", "build", "--prefix", installation_dir })
  end,
})

-- runs tests
use("vim-test/vim-test")

-- Live server for html css files edit on fly
use({ "turbio/bracey.vim", run = "npm install --prefix server" })

-- theme
use("bhushan/github-nvim-theme")
use("dracula/vim")

-- kitty config highlighting
use("fladson/vim-kitty")

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if PACKER_BOOTSTRAP then
  require("packer").sync()
end

vim.cmd("silent! colorscheme " .. os.getenv("SET_THEME"))

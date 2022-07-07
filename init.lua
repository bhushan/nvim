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
local packer_group = vim.api.nvim_create_augroup("packer_group", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerSync",
  group = packer_group,
  pattern = "init.lua",
})

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
    "p00f/nvim-ts-rainbow",
  },
  run = ":TSUpdate",
})

-- auto complete brackets
use({
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup()
  end,
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

-- file explorer, might be useful sometimes
-- use({
--     "kyazdani42/nvim-tree.lua",
--     requires = {
--         "kyazdani42/nvim-web-devicons", -- optional, for file icon
--     },
-- })

-- easily fuzzy file search
use({
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
  },
})

-- better navigation to and from nvim to tmux
use("christoomey/vim-tmux-navigator")

-- -- LSP plugins
-- use({
--     "neovim/nvim-lspconfig",
--     "williamboman/nvim-lsp-installer",
--     "hrsh7th/nvim-cmp",
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-nvim-lua",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-cmdline",
--     "octaltree/cmp-look", -- dictionary lookup
--     "saadparwaiz1/cmp_luasnip", -- needed for auto completion and auto imports in combination with LuaSnip
-- })
--
-- -- create cool new snippets
-- use("L3MON4D3/LuaSnip")

-- extra snippets
-- use({
--     "rafamadriz/friendly-snippets",
--     requires = { "L3MON4D3/LuaSnip" },
--     config = function()
--         require("luasnip/loaders/from_vscode").load({
--             paths = {
--                 "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
--             },
--         })
--     end,
-- })

-- git gutter
use({
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end,
})

-- integrate lazygit
-- use("kdheepak/lazygit.nvim")

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

-- present markdown files as presentation slides
use("sotte/presenting.vim")

-- theme
use("bhushan/github-nvim-theme")

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if PACKER_BOOTSTRAP then
  require("packer").sync()
end

-- dynamically set theme based on zshell env variable
if os.getenv("LIGHT_MODE") then
  vim.cmd([[silent! colorscheme github_light ]])
else
  vim.cmd([[silent! colorscheme github_dimmed ]])
end

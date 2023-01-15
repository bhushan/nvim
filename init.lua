local fn = vim.fn
local standard_path = fn.stdpath("data")
local install_path = standard_path .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
    is_bootstrap = true
    fn.system({
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

-- Show packer messages in a popup. Looks cooler
packer.init({
    compile_path = standard_path .. "/site/plugin/packer_compiled.lua",
    display = {
        open_fn = function()
            return require("packer.util").float({
                border = "solid",
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
    run = function()
        pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
})

-- colorise matching brackets
-- use({
--     "p00f/nvim-ts-rainbow",
--     requires = 'nvim-treesitter/nvim-treesitter'
-- })

-- auto complete brackets
use({
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,
            disable_in_macro = true,
        })
    end,
    requires = "nvim-treesitter/nvim-treesitter",
})

-- Add indentation guides even on blank lines
use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("indent_blankline").setup({
            char = "┊",
            show_trailing_blankline_indent = false,
        })
    end,
})

-- Additional text objects via treesitter
-- use({
--     "nvim-treesitter/nvim-treesitter-textobjects",
--     after = "nvim-treesitter",
-- })

-- get nice looking explorer for exploring files
-- use({
--     "nvim-tree/nvim-tree.lua",
--     requires = {
--         "nvim-tree/nvim-web-devicons",
--     },
-- })

-- file formatter same as prettier but with extra file types
-- use("sbdchd/neoformat")

-- better commenting using treesitter
use("tpope/vim-commentary")

-- extra surrounding keybindings
use("tpope/vim-surround")

-- extra keybindings starting with [ and ]
use("tpope/vim-unimpaired")

-- make tpope keybindings repeatable with . (dot)
use("tpope/vim-repeat")

-- Indent autodetection with editorconfig support
use("tpope/vim-sleuth")

-- use Rename Move command like these
use("tpope/vim-eunuch")

-- create parent directories if not exists while saving file
use("jessarcher/vim-heritage")

-- better syntax highlighting on top of treesitter
use("sheerun/vim-polyglot")

-- better html tag operation <motion>ax and <motion>ix
use({
    "whatyouhide/vim-textobj-xmlattr",
    requires = "kana/vim-textobj-user",
})

-- smooth scrolling while doing c-d and c-u
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
use({
    "sickill/vim-pasta",
    config = function()
        vim.g.pasta_disabled_filetypes = { "fugitive" }
    end,
})

-- awesome status line
use({
    "nvim-lualine/lualine.nvim",
    requires = {
        "nvim-tree/nvim-web-devicons",
    },
})

-- easily fuzzy file search
use({
    "nvim-telescope/telescope.nvim",
    requires = {
        { "nvim-lua/plenary.nvim" }, -- needed to do system task telescope dependency
        -- { "nvim-telescope/telescope-project.nvim" }, -- extension for project switching
        {
            "nvim-telescope/telescope-fzf-native.nvim", -- use fzf for quick search better regex based search
            cond = vim.fn.executable("make") == 1,
            run = "make",
        },
        { "nvim-telescope/telescope-file-browser.nvim" }, -- file browser
    },
})

-- better navigation to and from nvim to tmux
use("christoomey/vim-tmux-navigator")

-- better navigation to and from nvim to kitty
-- use("knubie/vim-kitty-navigator")

use({
    "hrsh7th/nvim-cmp", -- cmp is needed to show dropdown
    requires = {
        {
            "hrsh7th/cmp-nvim-lsp", -- cmp source to hook into lsp
            requires = {
                "neovim/nvim-lspconfig", -- lspconfigs for setting up lsp
                "williamboman/mason.nvim", -- lsp installer to install lsp servers
                "williamboman/mason-lspconfig.nvim",
            },
        },
        {
            "L3MON4D3/LuaSnip", -- create cool new snippets
            config = function()
                require("luasnip/loaders/from_vscode").load({
                    paths = {
                        "~/.config/nvim/luasnip",
                    },
                })
            end,
        },
        { "hrsh7th/cmp-nvim-lua" }, -- cmp source for nvim lua api
        { "saadparwaiz1/cmp_luasnip" }, -- needed for auto completion and auto imports in combination with LuaSnip
        -- { "hrsh7th/cmp-path" }, -- cmp source path
        -- { "hrsh7th/cmp-buffer" }, -- cmp source buffer
        -- { "hrsh7th/cmp-cmdline" }, -- cmp source cmdline
        { "octaltree/cmp-look" }, -- cmp source dictionary lookup
    },
})

-- git gutter
use("mhinz/vim-signify")

-- integrate lazygit
use("kdheepak/lazygit.nvim")

-- Better keybindings management and shows hints
use("folke/which-key.nvim")

-- Zend mode hightlighting block of code using treesitter
-- use("folke/twilight.nvim")

-- DAP
-- use({
--   "mfussenegger/nvim-dap",
--   requires = {
--     {
--       "theHamsta/nvim-dap-virtual-text",
--       config = function()
--         require("nvim-dap-virtual-text").setup()
--       end,
--     },
--     { "rcarriga/nvim-dap-ui" },
--   },
--   run = function()
--     local installation_dir = vim.fn.stdpath("data") .. "/dap/vscode-node-debug2"
--
--     fn.system({
--       "git",
--       "clone",
--       "--depth",
--       "1",
--       "https://github.com/microsoft/vscode-node-debug2",
--       installation_dir,
--     })
--     fn.system({ "npm", "install", "--prefix", installation_dir })
--     fn.system({ "npm", "run", "build", "--prefix", installation_dir })
--   end,
-- })

-- runs tests
use("vim-test/vim-test")

-- Live server for html css files edit on fly
-- use({ "turbio/bracey.vim", run = "npm install --prefix server" })

-- theme
-- use("bhushan/github-nvim-theme")
use({
    "dracula/vim",
    config = function()
        -- set theme based on zsh env variable
        vim.cmd.colorscheme(os.getenv("SET_THEME"))
        vim.api.nvim_set_hl(0, "DraculaWinSeparator", { fg = NONE, bg = NONE })
    end,
})

-- kitty config highlighting
-- use("fladson/vim-kitty")

-- vim game
-- use("ThePrimeagen/vim-be-good")

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if is_bootstrap then
    require("packer").sync()
end

-- Autocommand that reloads neovim whenever you save the init.lua file
local packer_group = vim.api.nvim_create_augroup("packer_group", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
    group = packer_group,
    pattern = vim.fn.expand("$MYVIMRC"),
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

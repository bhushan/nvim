local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local bootstraped = false

if fn.empty(fn.glob(install_path)) > 0 then
    bootstraped = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })

    vim.api.nvim_command("packadd packer.nvim")
end

return require("packer").startup({
    function(use)
        -- packer can manage itself
        use("wbthomason/packer.nvim")

        -- better syntax highlighting and parsing
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        })

        use({
            "terrortylor/nvim-comment",
            config = function()
                require("nvim_comment").setup()
            end,
        })

        -- awesome status line
        use({
            "nvim-lualine/lualine.nvim",
            requires = {
                "kyazdani42/nvim-web-devicons",
                opt = true,
            },
        })

        -- file explorer, might be useful sometimes
        use({
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons", -- optional, for file icon
            },
        })

        -- file formatter same as prettier but with extra file types
        use("sbdchd/neoformat")

        -- easily fuzzy file search
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                {
                    "nvim-lua/plenary.nvim",
                },
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    run = "make",
                },
            },
        })

        -- use telescope for code action
        use({ "nvim-telescope/telescope-ui-select.nvim" })

        -- better navigation to and from nvim to tmux
        use("christoomey/vim-tmux-navigator")

        -- LSP plugins
        use({
            "neovim/nvim-lspconfig",
            "williamboman/nvim-lsp-installer",

            -- { "tami5/lspsaga.nvim", branch = "nvim6.0" }, -- for now not using to see if it's worth it

            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "octaltree/cmp-look", -- dictionary lookup

            "saadparwaiz1/cmp_luasnip", -- needed for auto completion and auto imports in combination with LuaSnip
        })

        -- create cool new snippets
        use("L3MON4D3/LuaSnip")

        -- git gutter
        use("mhinz/vim-signify")

        -- theme
        use("projekt0n/github-nvim-theme")

        -- Better keybindings management and shows hints
        use("folke/which-key.nvim")

        if bootstraped then
            require("packer").sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})

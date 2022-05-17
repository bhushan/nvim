return require("packer").startup(function()
    -- packer can manage itself
    use("wbthomason/packer.nvim")

    -- better syntax highlighting and parsing
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
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

    -- better way to comment things
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- theme
    use("projekt0n/github-nvim-theme")

    -- Better keybindings management and shows hints
    use("folke/which-key.nvim")
end)

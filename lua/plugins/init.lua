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
        config = function()
            require("nvim-tree").setup({})
        end,
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
        "glepnir/lspsaga.nvim",
        requires = {
            {
                "neovim/nvim-lspconfig",
            },
        },
    })

    -- git gutter
    use("mhinz/vim-signify")

    -- vim surround
    use("tpope/vim-surround")

    -- theme
    use("morhetz/gruvbox")
    use("projekt0n/github-nvim-theme")
    use("michaeldyrynda/carbon")
end)

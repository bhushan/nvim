return require('packer').startup(function()
    -- packer can manage itself
    use 'wbthomason/packer.nvim'

    -- theme
    use 'shaunsingh/nord.nvim'
    use 'michaeldyrynda/carbon.vim'

    -- better syntax highlighting and parsing
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- awesome status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }

    -- file explorer, might be useful sometimes
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons' -- optional, for file icon
        },
        config = function()
            require'nvim-tree'.setup {}
        end
    }

    -- file formatter same as prettier but with extra file types
    use 'sbdchd/neoformat'
end)

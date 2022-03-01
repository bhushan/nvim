-- Config: telescope
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        },

        preview = false,

        file_ignore_patterns = {'.idea', '.vscode', 'node_modules', 'vendor', '.DS_Store'},

        winblend = 10,

        layout_config = {
            prompt_position = 'top',
            width = 0.75
        }
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
}

-- Custom finders
builtin.open_nvim_files = function()
    builtin.find_files(require('telescope.themes').get_dropdown {
        cwd = "$HOME/.config/nvim",
        prompt_title = "nvim config",
        previewer = false
    })
end

builtin.open_dotfiles = function()
    builtin.find_files(require('telescope.themes').get_dropdown {
        cwd = "$HOME/.dotfiles",
        prompt_title = 'Dotfiles',
        previewer = false,
        file_ignore_patterns = {'plugged'}
    })
end

telescope.load_extension('fzf')

-- Keymaps
local map = vim.api.nvim_set_keymap

map('n', '<leader>tf', ':Telescope find_files<cr>', {
    noremap = true,
    silent = true
})

map('n', '<leader>tg', ':Telescope live_grep<cr>', {
    noremap = true,
    silent = true
})

map('n', '<leader>tb', ':Telescope buffers<cr>', {
    noremap = true,
    silent = true
})

map('n', '<leader>th', ':Telescope help_tags<cr>', {
    noremap = true,
    silent = true
})

map('n', '<leader>tn', ':Telescope open_nvim_files<cr>', {
    noremap = true,
    silent = true
})

map('n', '<leader>td', ':Telescope open_dotfiles<cr>', {
    noremap = true,
    silent = true
})

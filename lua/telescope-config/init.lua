-- Config: telescope
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        prompt_prefix = "  ",

        preview = false,

        layout_config = {
            prompt_position = "top",
        },

        sorting_strategy = "ascending",

        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },

        file_ignore_patterns = {
            "^.git/",
            "^git/submodules/",
            "vendor",
            "node_modules",
            "^.idea",
            "^.vscode",
            "^.DStore",
        },
    },

    pickers = {
        find_files = {
            prompt_title = "All Files",
            find_command = { "rg", "--files", "--no-ignore", "--hidden" },
        },

        git_files = {
            prompt_title = "Project Files",
            find_command = { "rg", "--files" },
        },

        buffers = {
            sort_lastused = true,
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer",
                },
            },
        },
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

-- Custom finders
builtin.open_nvim_files = function()
    builtin.find_files(require("telescope.themes").get_dropdown({
        cwd = "$HOME/.config/nvim",
        prompt_title = "Nvim Config",
        previewer = false,
    }))
end

builtin.open_dotfiles = function()
    builtin.find_files(require("telescope.themes").get_dropdown({
        cwd = "$HOME/.dotfiles",
        prompt_title = "Dotfiles",
        previewer = false,
        file_ignore_patterns = { "plugged" },
    }))
end

telescope.load_extension("fzf")

-- Keymaps
local map = vim.api.nvim_set_keymap

map("n", "<leader>tf", ":Telescope find_files<cr>", {
    noremap = true,
    silent = true,
})

map("n", "<leader>tg", ":Telescope live_grep<cr>", {
    noremap = true,
    silent = true,
})

map("n", "<leader>tb", ":Telescope buffers<cr>", {
    noremap = true,
    silent = true,
})

map("n", "<leader>th", ":Telescope help_tags<cr>", {
    noremap = true,
    silent = true,
})

map("n", "<leader>tn", ":Telescope open_nvim_files<cr>", {
    noremap = true,
    silent = true,
})

map("n", "<leader>td", ":Telescope open_dotfiles<cr>", {
    noremap = true,
    silent = true,
})

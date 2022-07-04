-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        prompt_prefix = " 🔍 ",

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
    },

    pickers = {
        buffers = {
            sort_lastused = true,
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
    }))
end

telescope.load_extension("fzf")

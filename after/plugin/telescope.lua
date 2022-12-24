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

        selection_caret = " » ",

        path_display = { "shorten" },

        winblend = 10,

        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
    pickers = {
        find_files = {
            prompt_title = "Git Files",
            find_command = { "rg", "--files" },
            previewer = false,
        },
    },
    extensions = {
        file_browser = {
            previewer = false,
        },
    },
})

-- Custom finders
builtin.find_all_files = function()
    builtin.find_files({
        prompt_title = "All Files",
        find_command = { "rg", "--files", "--no-ignore", "--hidden" },
        previewer = false,
    })
end

-- Enable telescope fzf native, if installed to use regular expressions to search things in telescope
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "project")
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, "file_browser")

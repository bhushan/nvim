-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

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
      prompt_title = "All Files",
      find_command = { "rg", "--files", "--no-ignore", "--hidden" },
      previewer = false,
    },

    git_files = {
      prompt_title = "Project Files",
      find_command = { "rg", "--files" },
    },
  },
  extensions = {
    file_browser = {
      previewer = false,
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("file_browser")

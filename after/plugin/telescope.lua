-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " 🔍 ",

    selection_caret = "» ",

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

telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("file_browser")

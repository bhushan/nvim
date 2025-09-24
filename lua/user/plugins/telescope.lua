-- Help Menu, to know keybindings
--  - Insert mode: <c-/>
--  - Normal mode: ?
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    -- prompt_prefix = " 🔍 ",
    prompt_prefix = '   ',
    path_display = { truncate = 1 },
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
  },
  pickers = {
    oldfiles = {
      prompt_title = 'History',
    },
    lsp_references = {
      previewer = false,
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

-- safely load extentions if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'live_grep_args')
pcall(require('telescope').load_extension, 'project')
pcall(require('telescope').load_extension, 'file_browser')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<C-p>', function()
  builtin.find_files {
    prompt_title = 'Git Files',
    find_command = { 'rg', '--files' },
    previewer = false,
  }
end, { desc = 'Search Files' })

vim.keymap.set('n', '<C-p><C-p>', function()
  builtin.find_files {
    prompt_title = 'All Files',
    find_command = { 'rg', '--files', '--no-ignore', '--hidden' },
    previewer = false,
  }
end, { desc = 'Search All Files' })

vim.keymap.set('n', '<leader>ts', builtin.builtin, { desc = '[T]elescope [S]elect' })
vim.keymap.set('n', '<C-f>', function()
  builtin.live_grep {
    glob_pattern = '!_*',
  }
end, { desc = '[T]elescope by [G]rep' })

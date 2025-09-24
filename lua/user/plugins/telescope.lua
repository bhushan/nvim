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
vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = '[T]elescope [H]elp' })
vim.keymap.set('n', '<leader>tk', builtin.keymaps, { desc = '[T]elescope [K]eymaps' })

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
vim.keymap.set('n', '<leader>tw', builtin.grep_string, { desc = '[T]elescope current [W]ord' })
vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = '[T]elescope by [G]rep' })
vim.keymap.set('n', '<leader>td', builtin.diagnostics, { desc = '[T]elescope [D]iagnostics' })
vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = '[T]elescope [R]esume' })
vim.keymap.set('n', '<leader>t.', builtin.oldfiles, { desc = '[T]elescope Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>t/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[T]elescope [/] current buffer' })

--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>tf', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[T]elescope [F]iles in Open' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>tn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[T]elescope [N]eovim files' })

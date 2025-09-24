require('neo-tree').setup {
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  enable_git_status = false,
  enable_diagnostics = false,
  window = {
    width = 70,
    position = 'right',
    mappings = {
      ['\\'] = 'close_window',
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = true,
      hide_gitignored = false,
    },
  },
}

vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'Open Neotree' })

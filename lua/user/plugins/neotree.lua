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

vim.keymap.set('n', '<leader>ne', ':Neotree reveal<CR>', { desc = '[N]eotree [e]xplore' })
vim.keymap.set('n', '<leader>nf', ':Neotree focus<CR>', { desc = '[N]eotree [f]ocus' })
vim.keymap.set('n', '<leader>nc', ':Neotree close<CR>', { desc = '[N]eotree [c]lose' })
vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'Open Neotree (legacy)' })

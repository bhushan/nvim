require('snacks').setup {
  picker = {
    win = {
      input = {
        keys = {
          ['<C-c>'] = { 'close', mode = { 'n', 'i' } },
        },
      },
    },
  },
  terminal = {},
  scroll = { enabled = true },
  explorer = {},
  notifier = { enabled = true },
}

-- Setup picker keybindings
local picker = require('snacks').picker

vim.keymap.set('n', '<C-p>', function()
  picker.files {
    hidden = false,
    ignore = true,
  }
end, { desc = 'Search Files' })

vim.keymap.set('n', '<C-p><C-p>', function()
  picker.files {
    hidden = true,
    ignore = false,
  }
end, { desc = 'Search All Files' })

vim.keymap.set('n', '<leader>ts', function()
  picker.pick()
end, { desc = 'Show all pickers' })

vim.keymap.set('n', '<C-f>', function()
  picker.grep()
end, { desc = 'Search by Grep' })

-- Terminal keybindings to match floaterm
local terminal = require('snacks').terminal
vim.keymap.set('n', '`', function()
  terminal.toggle()
end, { desc = 'Toggle Terminal in normal mode', silent = true })
vim.keymap.set('t', '`', function()
  terminal.toggle()
end, { desc = 'Toggle Terminal in terminal mode', silent = true })

-- Explorer keybinding to match neotree
local explorer = require('snacks').explorer
vim.keymap.set('n', '\\', function()
  explorer.open()
end, { desc = 'Open Explorer', silent = true })

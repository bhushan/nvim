-- Claude Code Integration using claudecode.nvim
-- Official Neovim integration for Claude Code

-- Set up keybindings for claudecode.nvim
vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude Code' })
vim.keymap.set('v', '<leader>cs', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send selection to Claude Code' })
vim.keymap.set('n', '<leader>cf', '<cmd>ClaudeCode<cr>', { desc = 'Open Claude Code' })

-- Create additional user commands for convenience
vim.api.nvim_create_user_command('Claude', 'ClaudeCode', { desc = 'Open Claude Code' })
vim.api.nvim_create_user_command('ClaudeSend', 'ClaudeCodeSend', { desc = 'Send selection to Claude Code', range = true })

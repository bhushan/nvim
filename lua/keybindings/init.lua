vim.g.mapleader = ','

vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {
    noremap = true,
    silent = true
})

-- save
vim.api.nvim_set_keymap('n', '<leader>w', ':w<cr>', {
    noremap = true,
    silent = true
})

-- quit
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', {
    noremap = true,
    silent = true
})

-- force quit
vim.api.nvim_set_keymap('n', '<leader>fq', ':q!<cr>', {
    noremap = true,
    silent = true
})

vim.g.neoformat_run_all_formatters = 1

local map = vim.api.nvim_set_keymap

map('n', '<leader>f', ':Neoformat<cr>', {
    noremap = true,
    silent = true
})


vim.g.neoformat_run_all_formatters = 1

local map = vim.api.nvim_set_keymap

map('n', '<leader>f', ':Neoformat<cr>', {
    noremap = true,
    silent = true
})

-- auto format code when file is saved
vim.cmd([[
augroup auto_format_group
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])

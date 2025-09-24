-- Detect .blade.php files as blade filetype for proper snippet support
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.blade.php',
  callback = function()
    vim.bo.filetype = 'blade'
  end,
})

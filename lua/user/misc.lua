-- Run Pint on save in PHP files
local pint_group = vim.api.nvim_create_augroup('PintOnSave', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.php',
  command = 'silent !./vendor/bin/pint %',
  group = pint_group,
})

-- Run Stylua on save in Lua files
local stylua_group = vim.api.nvim_create_augroup('StyluaOnSave', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.lua',
  command = 'silent !stylua %',
  group = stylua_group,
})

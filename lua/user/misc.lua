-- run pint on save in php files
vim.api.nvim_exec([[
  augroup PintOnSave
    autocmd!
    autocmd BufWritePost *.php silent !./vendor/bin/pint %
  augroup END
]], false)

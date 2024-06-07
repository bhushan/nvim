-- run pint on save in php files
vim.api.nvim_exec(
  [[
  augroup PintOnSave
    autocmd!
    autocmd BufWritePost *.php silent !./vendor/bin/pint %
  augroup END
]],
  false
)

-- run stylua on save in lua files
vim.api.nvim_exec(
  [[
  augroup StyluaOnSave
    autocmd!
    autocmd BufWritePost *.lua silent !stylua %
  augroup END
]],
  false
)

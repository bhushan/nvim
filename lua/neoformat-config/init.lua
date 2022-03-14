-- Enable alignment
vim.g.neoformat_basic_format_align = true

-- Enable tab to spaces conversion
vim.g.neoformat_basic_format_retab = true

-- Enable trimmming of trailing whitespace
vim.g.neoformat_basic_format_trim = true

-- Run all enabled formatters (by default Neoformat stops after the first formatter succeeds)
vim.g.neoformat_run_all_formatters = true

-- augroup auto_format_group
--   autocmd!
--   autocmd BufWritePre * undojoin | Neoformat
-- augroup END
-- ]])

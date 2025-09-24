vim.keymap.set('n', '<Leader>rn', ':TestNearest<CR>', { desc = '[R]un [n]earest test' })
vim.keymap.set('n', '<Leader>rf', ':TestFile<CR>', { desc = '[R]un test [f]ile' })
vim.keymap.set('n', '<Leader>rs', ':TestSuite<CR>', { desc = '[R]un test [s]uite' })
vim.keymap.set('n', '<Leader>rl', ':TestLast<CR>', { desc = '[R]un [l]ast test' })
vim.keymap.set('n', '<Leader>rv', ':TestVisit<CR>', { desc = '[R]un [v]isit test' })

vim.cmd [[
  let test#php#phpunit#options = '--colors=always'
  let test#php#pest#options = '--colors=always'

  function! FloatermStrategy(cmd)
    execute 'silent FloatermKill'
    execute 'FloatermNew! '.a:cmd.' |less -X'
  endfunction

  let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
  let g:test#strategy = 'floaterm'
]]

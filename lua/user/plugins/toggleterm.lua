local toggleterm = require 'toggleterm'

toggleterm.setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'vertical',
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = 'curved',
    winblend = 0,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
}

-- Custom terminal configurations
local Terminal = require('toggleterm.terminal').Terminal

-- Claude Code terminal in side panel
local claude_code = Terminal:new {
  cmd = 'claude-code',
  dir = 'git_dir',
  direction = 'vertical',
  size = vim.o.columns * 0.4,
  close_on_exit = false,
  on_open = function(term)
    vim.cmd 'startinsert!'
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true })
  end,
}

-- Horizontal terminal for quick commands
local horizontal_term = Terminal:new {
  direction = 'horizontal',
  size = 15,
}

-- Floating terminal for quick tasks
local floating_term = Terminal:new {
  direction = 'float',
}

-- PHP Artisan terminal
local artisan_term = Terminal:new {
  cmd = 'php artisan tinker',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  on_open = function(term)
    vim.cmd 'startinsert!'
  end,
}

-- Node REPL terminal
local node_term = Terminal:new {
  cmd = 'node',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  on_open = function(term)
    vim.cmd 'startinsert!'
  end,
}

-- Functions to toggle terminals
function _G.claude_code_toggle()
  claude_code:toggle()
end

function _G.horizontal_term_toggle()
  horizontal_term:toggle()
end

function _G.floating_term_toggle()
  floating_term:toggle()
end

function _G.artisan_toggle()
  artisan_term:toggle()
end

function _G.node_toggle()
  node_term:toggle()
end

-- Key mappings for terminal management
vim.keymap.set('n', '<leader>cc', '<cmd>lua claude_code_toggle()<CR>', { desc = 'Toggle Claude Code' })
vim.keymap.set('n', '<leader>th', '<cmd>lua horizontal_term_toggle()<CR>', { desc = 'Toggle Horizontal Terminal' })
vim.keymap.set('n', '<leader>tf', '<cmd>lua floating_term_toggle()<CR>', { desc = 'Toggle Floating Terminal' })

-- Language-specific terminals
vim.keymap.set('n', '<leader>ta', '<cmd>lua artisan_toggle()<CR>', { desc = 'Toggle Artisan Terminal' })
vim.keymap.set('n', '<leader>tn', '<cmd>lua node_toggle()<CR>', { desc = 'Toggle Node Terminal' })

-- Better terminal navigation
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- Apply terminal keymaps when entering terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = function()
    set_terminal_keymaps()
  end,
})

-- Auto-resize terminals when window is resized
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    vim.cmd 'ToggleTermSetAll'
  end,
})

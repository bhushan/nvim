-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`
local api = vim.api

--- Disable automatic comment continuation on new lines
--- Removes 'c', 'r', 'o' from formatoptions to prevent auto-commenting
--- when pressing Enter or 'o'/'O' in normal mode
api.nvim_create_autocmd('BufEnter', { command = [[set formatoptions-=cro]] })

--- Briefly highlight yanked text for visual feedback
--- Triggered after any yank operation (y, d, c, etc.)
--- @usage Try with `yap` in normal mode to yank a paragraph
local group = vim.api.nvim_create_augroup('highlight-yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { timeout = 200 }
  end,
})

--- Restore cursor to last known position when opening a buffer
--- Uses the '"' mark which stores the last cursor position before exit
--- Skips if the saved position is invalid or beyond buffer end
api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

--- Display cursor line only in the active window
--- Improves focus by hiding cursorline in inactive windows and insert mode
local cursorGrp = api.nvim_create_augroup('CursorLine', { clear = true })
api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = cursorGrp,
})
api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  command = 'set nocursorline',
  group = cursorGrp,
})

--- Enable spell checking for text-based file types
--- Activates for .txt, .md, and .tex files with English dictionary
api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.txt', '*.md', '*.tex' },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en'
  end,
})

--- Map 'q' to close specific utility/informational buffers
--- Applies to help, quickfix, LSP info, and other temporary windows
--- Removes these buffers from the buffer list to keep it clean
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

--- Auto-resize splits proportionally when terminal window is resized
--- Maintains balanced split layout across window dimension changes
vim.api.nvim_command 'autocmd VimResized * wincmd ='

--- Enable Tree-sitter highlighting automatically for all file types
--- Provides superior syntax highlighting and code understanding
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

--- Automatically insert PHP opening tag for new PHP files
--- Adds '<?php' as the first line when creating a new PHP file
--- Only triggers if the file is empty (new file)
api.nvim_create_autocmd({ 'BufNewFile' }, {
  pattern = '*.php',
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #lines == 1 and lines[1] == '' then
      vim.api.nvim_buf_set_lines(0, 0, 1, false, { '<?php', '' })
      vim.api.nvim_win_set_cursor(0, { 2, 0 })
      -- Ensure filetype is set immediately for new PHP files
      vim.bo.filetype = 'php'
    end
  end,
})

--- Terraform filetype detection and formatting
--- Sets proper filetype for various Terraform and HCL files
--- Enables auto-formatting on save and alignment
local terraform_group = api.nvim_create_augroup('terraform', { clear = true })

api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = terraform_group,
  pattern = '*.hcl',
  callback = function()
    vim.bo.filetype = 'hcl'
  end,
})

api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = terraform_group,
  pattern = { '.terraformrc', 'terraform.rc' },
  callback = function()
    vim.bo.filetype = 'hcl'
  end,
})

api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = terraform_group,
  pattern = { '*.tf', '*.tfvars' },
  callback = function()
    vim.bo.filetype = 'terraform'
  end,
})

api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = terraform_group,
  pattern = { '*.tfstate', '*.tfstate.backup' },
  callback = function()
    vim.bo.filetype = 'json'
  end,
})

api.nvim_create_autocmd('FileType', {
  group = terraform_group,
  pattern = 'terraform',
  callback = function()
    vim.g.terraform_fmt_on_save = 1
    vim.g.terraform_align = 1
  end,
})

--- Detach LSP from buffers marked with lsp_disabled
--- Used by ftplugin files to skip LSP for minified files
api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    if vim.b[args.buf].lsp_disabled then
      vim.schedule(function()
        vim.lsp.buf_detach_client(args.buf, args.data.client_id)
      end)
    end
  end,
})

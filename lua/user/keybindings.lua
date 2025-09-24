-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- easily access command line mode
vim.keymap.set('n', ';', ':')
vim.keymap.set('v', ';', ':')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')

-- Disable annoying command line typo.
vim.keymap.set('n', 'q:', ':q')

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- use jj to escape in insert mode.
vim.keymap.set('i', 'jj', '<Esc>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- PHP and JavaScript Productivity Keybindings

-- Quick file navigation
vim.keymap.set('n', '<leader>pf', '<cmd>Telescope find_files<cr>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>pg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>pb', '<cmd>Telescope buffers<cr>', { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>ph', '<cmd>Telescope help_tags<cr>', { desc = 'Help Tags' })
vim.keymap.set('n', '<leader>ps', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>pw', '<cmd>Telescope lsp_workspace_symbols<cr>', { desc = 'Workspace Symbols' })

-- Git integration shortcuts
vim.keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<cr>', { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { desc = 'Git Branches' })
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc = 'Git Commits' })

-- Neo-tree file explorer
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle File Explorer' })
vim.keymap.set('n', '<leader>ef', '<cmd>Neotree focus<cr>', { desc = 'Focus File Explorer' })

-- LSP productivity shortcuts
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'LSP Rename' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'LSP Format' })
vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP Info' })
vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<cr>', { desc = 'LSP Restart' })

-- Testing shortcuts (works with vim-test)
vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<cr>', { desc = 'Test Nearest' })
vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>', { desc = 'Test File' })
vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<cr>', { desc = 'Test Suite' })
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>', { desc = 'Test Last' })
vim.keymap.set('n', '<leader>tv', '<cmd>TestVisit<cr>', { desc = 'Test Visit' })

-- Buffer management for faster workflow
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<s-tab>', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })

-- Quick save and quit
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>wa', '<cmd>wa<cr>', { desc = 'Save All' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>qa', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Split management
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>sh', '<cmd>split<cr>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Equal Splits' })
vim.keymap.set('n', '<leader>sx', '<cmd>close<cr>', { desc = 'Close Split' })

-- Format on save for specific filetypes (productivity boost)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.php', '*.js', '*.ts', '*.jsx', '*.tsx', '*.vue', '*.css', '*.scss', '*.html', '*.json', '*.yaml', '*.md' },
  callback = function()
    if vim.fn.exists(':ConformInfo') == 2 then
      require('conform').format({ async = false })
    else
      vim.lsp.buf.format()
    end
  end,
})

-- PHP-specific shortcuts
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set('n', '<leader>pa', '<cmd>!php artisan<cr>', { desc = 'PHP Artisan', buffer = bufnr })
    vim.keymap.set('n', '<leader>pc', '<cmd>!composer<cr>', { desc = 'Composer', buffer = bufnr })
    vim.keymap.set('n', '<leader>pu', '<cmd>!./vendor/bin/phpunit<cr>', { desc = 'PHPUnit', buffer = bufnr })
    vim.keymap.set('n', '<leader>ps', '<cmd>!php artisan serve<cr>', { desc = 'Laravel Serve', buffer = bufnr })
  end,
})

-- JavaScript/Node.js specific shortcuts
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set('n', '<leader>nr', '<cmd>!npm run<cr>', { desc = 'NPM Run', buffer = bufnr })
    vim.keymap.set('n', '<leader>ni', '<cmd>!npm install<cr>', { desc = 'NPM Install', buffer = bufnr })
    vim.keymap.set('n', '<leader>nt', '<cmd>!npm test<cr>', { desc = 'NPM Test', buffer = bufnr })
    vim.keymap.set('n', '<leader>nd', '<cmd>!npm run dev<cr>', { desc = 'NPM Dev', buffer = bufnr })
    vim.keymap.set('n', '<leader>nb', '<cmd>!npm run build<cr>', { desc = 'NPM Build', buffer = bufnr })
    vim.keymap.set('n', '<leader>nl', '<cmd>!npm run lint<cr>', { desc = 'NPM Lint', buffer = bufnr })
  end,
})

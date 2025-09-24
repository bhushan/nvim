local wk = require('which-key')

wk.setup({
  preset = 'modern',
  delay = function(ctx)
    return ctx.plugin and 0 or 200
  end,
  win = {
    border = 'rounded',
    padding = { 1, 2 },
  },
  layout = {
    spacing = 3,
  },
})

-- Register key groups and descriptions
wk.add({
  -- File operations
  { '<leader>f', group = 'File' },
  { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
  { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
  { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
  { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
  { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },

  -- Git operations
  { '<leader>g', group = 'Git' },
  { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Git Status' },
  { '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = 'Git Branches' },
  { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = 'Git Commits' },
  { '<leader>gf', '<cmd>Telescope git_files<cr>', desc = 'Git Files' },

  -- LSP operations
  { '<leader>l', group = 'LSP' },
  { '<leader>lr', vim.lsp.buf.rename, desc = 'Rename' },
  { '<leader>la', vim.lsp.buf.code_action, desc = 'Code Action' },
  { '<leader>lf', vim.lsp.buf.format, desc = 'Format' },
  { '<leader>li', '<cmd>LspInfo<cr>', desc = 'LSP Info' },
  { '<leader>lR', '<cmd>LspRestart<cr>', desc = 'Restart LSP' },
  { '<leader>ld', vim.diagnostic.open_float, desc = 'Show Diagnostics' },
  { '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document Symbols' },
  { '<leader>lw', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'Workspace Symbols' },

  -- Testing
  { '<leader>t', group = 'Test' },
  { '<leader>tn', '<cmd>TestNearest<cr>', desc = 'Test Nearest' },
  { '<leader>tf', '<cmd>TestFile<cr>', desc = 'Test File' },
  { '<leader>ts', '<cmd>TestSuite<cr>', desc = 'Test Suite' },
  { '<leader>tl', '<cmd>TestLast<cr>', desc = 'Test Last' },
  { '<leader>tv', '<cmd>TestVisit<cr>', desc = 'Test Visit' },

  -- Claude Code Integration
  { '<leader>c', group = 'Claude Code' },
  { '<leader>cc', desc = 'Toggle Claude Panel' },
  { '<leader>cf', desc = 'Send File to Claude' },
  { '<leader>cs', desc = 'Send Selection to Claude', mode = 'v' },
  { '<leader>cq', desc = 'Claude Quick Commands' },
  { '<leader>cp', desc = 'Send Project to Claude' },
  { '<leader>ce', desc = 'Explain Error with Claude' },
  { '<leader>cF', desc = 'Quick Claude Float' },
  { '<leader>ca', desc = 'Ask Claude about Symbol' },

  -- Terminal Management
  { '<leader>T', group = 'Terminal' },
  { '<leader>Th', '<cmd>lua horizontal_term_toggle()<CR>', desc = 'Horizontal Terminal' },
  { '<leader>Tf', '<cmd>lua floating_term_toggle()<CR>', desc = 'Floating Terminal' },
  { '<leader>Ta', '<cmd>lua artisan_toggle()<CR>', desc = 'Artisan Terminal' },
  { '<leader>Tn', '<cmd>lua node_toggle()<CR>', desc = 'Node Terminal' },

  -- Buffer operations
  { '<leader>b', group = 'Buffer' },
  { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Delete Buffer' },
  { '<leader>bn', '<cmd>bnext<cr>', desc = 'Next Buffer' },
  { '<leader>bp', '<cmd>bprevious<cr>', desc = 'Previous Buffer' },
  { '<leader>bf', '<cmd>Telescope buffers<cr>', desc = 'Find Buffer' },

  -- Window/Split operations
  { '<leader>s', group = 'Split' },
  { '<leader>sv', '<cmd>vsplit<cr>', desc = 'Vertical Split' },
  { '<leader>sh', '<cmd>split<cr>', desc = 'Horizontal Split' },
  { '<leader>se', '<C-w>=', desc = 'Equal Splits' },
  { '<leader>sx', '<cmd>close<cr>', desc = 'Close Split' },

  -- Project/Search operations
  { '<leader>p', group = 'Project' },
  { '<leader>pf', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
  { '<leader>pg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
  { '<leader>pb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
  { '<leader>ph', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
  { '<leader>ps', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document Symbols' },
  { '<leader>pw', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'Workspace Symbols' },

  -- Debug operations
  { '<leader>d', group = 'Debug' },
  { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Toggle Breakpoint' },
  { '<leader>dc', '<cmd>DapContinue<cr>', desc = 'Continue' },
  { '<leader>ds', '<cmd>DapStepOver<cr>', desc = 'Step Over' },
  { '<leader>di', '<cmd>DapStepInto<cr>', desc = 'Step Into' },
  { '<leader>do', '<cmd>DapStepOut<cr>', desc = 'Step Out' },
  { '<leader>dt', '<cmd>DapTerminate<cr>', desc = 'Terminate' },
  { '<leader>du', '<cmd>lua require("dapui").toggle()<cr>', desc = 'Toggle DAP UI' },

  -- File Explorer
  { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle Explorer' },
  { '<leader>E', '<cmd>Neotree focus<cr>', desc = 'Focus Explorer' },

  -- Quick actions
  { '<leader>w', '<cmd>w<cr>', desc = 'Save File' },
  { '<leader>q', '<cmd>q<cr>', desc = 'Quit' },
  { '<leader>x', '<cmd>x<cr>', desc = 'Save & Quit' },
})

-- Add language-specific keybindings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    wk.add({
      { '<leader>P', group = 'PHP', buffer = true },
      { '<leader>Pa', '<cmd>!php artisan<cr>', desc = 'Artisan', buffer = true },
      { '<leader>Pc', '<cmd>!composer<cr>', desc = 'Composer', buffer = true },
      { '<leader>Pu', '<cmd>!./vendor/bin/phpunit<cr>', desc = 'PHPUnit', buffer = true },
      { '<leader>Ps', '<cmd>!php artisan serve<cr>', desc = 'Laravel Serve', buffer = true },
      { '<leader>Pt', '<cmd>lua artisan_toggle()<CR>', desc = 'Artisan Terminal', buffer = true },
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    wk.add({
      { '<leader>N', group = 'Node/NPM', buffer = true },
      { '<leader>Nr', '<cmd>!npm run<cr>', desc = 'NPM Run', buffer = true },
      { '<leader>Ni', '<cmd>!npm install<cr>', desc = 'NPM Install', buffer = true },
      { '<leader>Nt', '<cmd>!npm test<cr>', desc = 'NPM Test', buffer = true },
      { '<leader>Nd', '<cmd>!npm run dev<cr>', desc = 'NPM Dev', buffer = true },
      { '<leader>Nb', '<cmd>!npm run build<cr>', desc = 'NPM Build', buffer = true },
      { '<leader>Nl', '<cmd>!npm run lint<cr>', desc = 'NPM Lint', buffer = true },
      { '<leader>Nn', '<cmd>lua node_toggle()<CR>', desc = 'Node Terminal', buffer = true },
    })
  end,
})
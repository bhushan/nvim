-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

--- Quick command mode access using semicolon
--- Replaces ; with : for faster command entry in normal and visual modes
vim.keymap.set('n', ';', ':')
vim.keymap.set('v', ';', ':')

--- Clear search highlight on Escape
--- Removes search highlighting without affecting other functionality
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--- Navigate wrapped lines naturally
--- Moves by visual lines when no count is given, by actual lines with count
--- Improves editing experience with long wrapped text
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

--- Maintain visual selection after indenting
--- Keeps text selected for repeated indent/dedent operations
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

--- Preserve cursor position when yanking visual selection
--- Prevents cursor jump after yank operation
--- @see http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')

--- Fix common command-line typos
--- Maps q: to :q to prevent opening command history window accidentally
vim.keymap.set('n', 'q:', ':q')

--- Command alias for common save typo
--- Maps :W to :w for convenient saving
vim.api.nvim_create_user_command('W', 'w', {})

--- Command abbreviation to quit all buffers
--- Maps :q to :qa for quitting all at once
vim.cmd 'cnoreabbrev q qa'

--- Paste over visual selection without yanking deleted text
--- Uses black hole register to avoid polluting default register
vim.keymap.set('v', 'p', '"_dP')

--- Quick escape from insert mode
--- Double-tap 'j' to exit insert mode faster than reaching for Escape
vim.keymap.set('i', 'jj', '<Esc>')

-- auto center always
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

--- Exit terminal mode with double Escape
--- More discoverable alternative to <C-\><C-n>
--- Note: May not work in all terminal emulators or tmux
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--- Disable arrow keys in normal mode
--- Enforces hjkl movement for muscle memory training
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--- Window navigation using Ctrl + hjkl
--- Simplifies split window focus switching
--- @see `:help wincmd` for all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--- Close current buffer with Ctrl-w
--- Deletes buffer without closing window
vim.keymap.set('n', '<C-w>', '<cmd>bdelete<CR>', { desc = 'Close current buffer' })

--- Diagnostic keybindings
--- View and navigate LSP diagnostics (errors, warnings, etc.)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show [d]iagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

--- Terraform commands
--- Run common Terraform operations directly from Neovim
vim.keymap.set('n', '<leader>ti', '<cmd>!terraform init<CR>', { desc = 'Terraform init' })
vim.keymap.set('n', '<leader>tv', '<cmd>!terraform validate<CR>', { desc = 'Terraform validate' })
vim.keymap.set('n', '<leader>tp', '<cmd>!terraform plan<CR>', { desc = 'Terraform plan' })
vim.keymap.set('n', '<leader>ta', '<cmd>!terraform apply<CR>', { desc = 'Terraform apply' })
vim.keymap.set('n', '<leader>tA', '<cmd>!terraform apply -auto-approve<CR>', { desc = 'Terraform apply auto-approve' })

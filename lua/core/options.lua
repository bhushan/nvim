-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`

--- Leader key configuration
--- Set comma as the leader key for custom mappings
--- Must be set before plugins are loaded to ensure correct leader key
--- @see `:help mapleader`
vim.g.mapleader = ','
vim.g.maplocalleader = ','

--- Nerd Font support flag
--- Set to true if a Nerd Font is installed in your terminal
--- Enables proper icon rendering in plugins
vim.g.have_nerd_font = true

--- Display line numbers in the gutter
--- Provides absolute line numbers for navigation and reference
vim.opt.number = true

--- Provides relative line numbers for navigation and reference
vim.opt.relativenumber = true

--- Enable search result highlighting
--- Highlights all matches for the current search pattern
vim.opt.hlsearch = true

--- PHP-optimized indentation settings
--- Converts tabs to spaces with 4-space indent width
--- Standard PSR-12 compliant configuration for PHP development
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

--- Command-line completion behavior
--- First tab completes longest common string, subsequent tabs cycle through options
vim.opt.wildmode = 'longest:full,full'

--- Insert mode completion options
--- Shows menu, selects longest match, displays preview window
vim.opt.completeopt = 'menuone,longest,preview'

--- Enable mouse support in all modes
--- Useful for resizing splits and quick navigation
vim.opt.mouse = 'a'

--- Hide mode indicator from command line
--- Mode is already shown in status line, reducing redundancy
vim.opt.showmode = false

--- Sync system clipboard with Neovim registers
--- Allows seamless copy/paste between Neovim and other applications
--- @see `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

--- Preserve indentation on wrapped lines
--- Wrapped lines maintain visual indent alignment
vim.opt.breakindent = true

--- Persistent undo configuration
--- Maintains undo history across Neovim sessions
vim.opt.undofile = true

--- Automatic backup file creation
--- Creates backup files before overwriting, stored outside current directory
vim.opt.backup = true
vim.opt.backupdir:remove '.'

--- Smart case-insensitive search
--- Case-insensitive unless pattern contains uppercase or \C
vim.opt.ignorecase = true
vim.opt.smartcase = true

--- Sign column configuration
--- Always show sign column with width of 2 to prevent layout shift
--- Displays diagnostic signs, git changes, breakpoints, etc.
vim.opt.signcolumn = 'yes:2'

--- Faster CursorHold and swap file write
--- Reduces delay for autocommands and improves responsiveness
vim.opt.updatetime = 250

--- Shorter mapped sequence timeout
--- Displays which-key popup faster for key mapping discovery
vim.opt.timeoutlen = 300

--- Intuitive split window placement
--- New horizontal splits open below, vertical splits open right
vim.opt.splitright = true
vim.opt.splitbelow = true

--- Whitespace character visualization
--- Displays tabs, trailing spaces, and non-breaking spaces
--- @see `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--- Clean end-of-buffer appearance
--- Removes tilde (~) characters from lines beyond buffer end
vim.opt.fillchars:append { eob = ' ' }

--- Live substitution preview
--- Shows substitution results in split window as you type
vim.opt.inccommand = 'split'

--- Disable cursor line highlighting
--- Reduces visual noise (can be re-enabled in active window via autocommands)
vim.opt.cursorline = false

--- Maintain context while scrolling
--- Keeps 8 lines visible above/below and left/right of cursor
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

--- Prompt for confirmation on unsaved changes
--- Prevents accidental data loss by asking before discarding changes
vim.opt.confirm = true

--- Fold configuration
--- Keep all folds open by default and disable automatic folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

--- Diagnostic sign configuration
--- Custom icons for error, warning, info, and hint diagnostics
--- Uses Nerd Font icons for visual clarity
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.INFO] = '󰌶',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
}

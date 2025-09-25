require('snacks').setup {
  bigfile = { enabled = true }, -- Disable features on big files for performance
  quickfile = { enabled = true }, -- Fast file opening
  git = { enabled = true }, -- Git integration for root detection
  picker = {
    matcher = {
      frecency = true, -- Use frequency + recency for better results
      max_results = 50, -- Limit results for performance
    },
    win = {
      border = 'none',
      input = {
        border = 'none',
        keys = {
          ['<C-c>'] = { 'close', mode = { 'n', 'i' } },
          ['<esc>'] = { 'close', mode = { 'n', 'i' } },
        },
      },
    },
    sources = {
      explorer = {
        layout = {
          layout = {
            position = 'right', -- Note: layout twice
          },
        },
      },
      files = {
        hidden = false,
        follow_symlinks = false, -- Better performance
      },
    },
  },
  terminal = {
    win = {
      width = 0.8,
      height = 0.8,
      border = 'none',
    },
  },
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 15, total = 250 }, -- Fast smooth scrolling
      easing = 'linear',
    },
  },
  explorer = {
    enabled = true,
    replace_netrw = true,
    win = {
      border = 'none',
    },
  },
  notifier = {
    enabled = true,
    timeout = 3000, -- Auto-dismiss after 3s
    width = { min = 40, max = 0.4 },
    height = { min = 1, max = 0.6 },
    margin = { top = 0, right = 1, bottom = 0 },
    padding = { top = 0, right = 1, bottom = 0, left = 1 },
    sort = { 'level', 'added' }, -- Show errors first
    level = vim.log.levels.INFO, -- Don't show debug messages
    border = 'none',
    icons = {
      error = ' ',
      warn = ' ',
      info = ' ',
      debug = ' ',
      trace = ' ',
    },
  },
  statuscolumn = { enabled = true }, -- Better gutter performance
  words = { enabled = true }, -- Fast LSP reference highlighting
}

-- Setup picker keybindings for performance
local picker = require('snacks').picker

-- Fast file searching with smart defaults
vim.keymap.set('n', '<C-p>', function()
  picker.smart() -- Automatically chooses git_files or files
end, { desc = 'Smart File Search' })

vim.keymap.set('n', '<C-p><C-p>', function()
  picker.files { hidden = true }
end, { desc = 'Search All Files' })

-- Recent files for quick access
vim.keymap.set('n', '<leader>fr', function()
  picker.recent()
end, { desc = 'Recent Files' })

-- Fast buffer switching
vim.keymap.set('n', '<leader><space>', function()
  picker.buffers()
end, { desc = 'Switch Buffers' })

vim.keymap.set('n', '<leader>ts', function()
  picker.pick()
end, { desc = 'Show all pickers' })

-- Optimized grep with word boundary
vim.keymap.set('n', '<C-f>', function()
  picker.grep()
end, { desc = 'Live Grep' })

-- Grep word under cursor for quick searches
vim.keymap.set('n', '<leader>fw', function()
  picker.grep_word()
end, { desc = 'Grep Word Under Cursor' })

-- Terminal keybindings to match floaterm
local terminal = require('snacks').terminal
vim.keymap.set('n', '`', function()
  terminal.toggle()
end, { desc = 'Toggle Terminal in normal mode', silent = true })
vim.keymap.set('t', '`', function()
  terminal.toggle()
end, { desc = 'Toggle Terminal in terminal mode', silent = true })

-- Explorer keybinding to match neotree
local explorer = require('snacks').explorer
vim.keymap.set('n', '\\', function()
  explorer.open()
end, { desc = 'Open Explorer', silent = true })

-- Performance optimizations and explorer enhancements
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_picker',
  callback = function(ev)
    local bufname = vim.api.nvim_buf_get_name(ev.buf)
    if bufname:match 'explorer' then
      -- Performance: Set buffer-local options for explorer
      vim.opt_local.wrap = false
      vim.opt_local.cursorline = true

      -- Close explorer with same key
      vim.keymap.set('n', '\\', '<cmd>close<cr>', { desc = 'Close Explorer', buffer = ev.buf, silent = true })
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { desc = 'Close Explorer', buffer = ev.buf, silent = true })
    end
  end,
})

-- Performance: Enable word highlighting after startup
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    if package.loaded['snacks'] and require('snacks').words then
      require('snacks').words.enable()
    end

    -- Auto-detect and change to project root (replaces vim-rooter)
    local function find_root()
      local patterns = { '.git', 'package.json', 'composer.json', 'Makefile', 'README.md' }
      local current_dir = vim.fn.expand '%:p:h'

      local function find_pattern_upward(dir, patterns)
        for _, pattern in ipairs(patterns) do
          local path = dir .. '/' .. pattern
          if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
            return dir
          end
        end
        local parent = vim.fn.fnamemodify(dir, ':h')
        if parent == dir then
          return nil
        end
        return find_pattern_upward(parent, patterns)
      end

      local root = find_pattern_upward(current_dir, patterns)
      if root and root ~= vim.fn.getcwd() then
        vim.cmd('cd ' .. root)
      end
    end

    -- Change to root when opening files
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
      callback = find_root,
    })

    -- Run once on startup
    find_root()
  end,
})

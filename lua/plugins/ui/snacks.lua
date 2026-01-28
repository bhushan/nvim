require('snacks').setup {
  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1 },
      -- { icon = ' ', title = 'Projects', section = 'projects', indent = 2, limit = 8 },
      { section = 'startup' },
    },
    preset = {
      header = [[
    ███████╗███╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗███████╗██████╗ ██╗███╗   ██╗ ██████╗ 
    ██╔════╝████╗  ██║██╔════╝ ██║████╗  ██║██╔════╝██╔════╝██╔══██╗██║████╗  ██║██╔════╝ 
    █████╗  ██╔██╗ ██║██║  ███╗██║██╔██╗ ██║█████╗  █████╗  ██████╔╝██║██╔██╗ ██║██║  ███╗
    ██╔══╝  ██║╚██╗██║██║   ██║██║██║╚██╗██║██╔══╝  ██╔══╝  ██╔══██╗██║██║╚██╗██║██║   ██║
    ███████╗██║ ╚████║╚██████╔╝██║██║ ╚████║███████╗███████╗██║  ██║██║██║ ╚████║╚██████╔╝
    ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
                                                                                            
    ██╗███████╗    ██████╗ ███████╗ █████╗ ██╗   ██╗████████╗██╗███████╗██╗   ██╗██╗      
    ██║██╔════╝    ██╔══██╗██╔════╝██╔══██╗██║   ██║╚══██╔══╝██║██╔════╝██║   ██║██║      
    ██║███████╗    ██████╔╝█████╗  ███████║██║   ██║   ██║   ██║█████╗  ██║   ██║██║      
    ██║╚════██║    ██╔══██╗██╔══╝  ██╔══██║██║   ██║   ██║   ██║██╔══╝  ██║   ██║██║      
    ██║███████║    ██████╔╝███████╗██║  ██║╚██████╔╝   ██║   ██║██║     ╚██████╔╝███████╗ 
    ╚═╝╚══════╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝╚═╝      ╚═════╝ ╚══════╝ 
                                                                                            
                                        ~ rb
      ]],
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files()' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.picker.grep()' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
  },

  notifier = {
    enabled = true,
    timeout = 3000,
  },
  input = {
    enabled = true,
  },
  picker = {
    ui_select = true, -- Enable vim.ui.select integration
    sources = {
      explorer = {
        hidden = true,
        ignored = true,
        layout = {
          layout = {
            width = 0.4,
            position = 'right', -- Note: layout twice
          },
        },
      },
    },
  },

  terminal = {
    win = {
      width = 0.8,
      height = 0.8,
    },
  },

  scroll = {
    enabled = true,
  },

  explorer = {
    enabled = true,
    replace_netrw = true,
  },
}

-- Setup picker keybindings for performance
local picker = require('snacks').picker

-- Additional powerful keybindings for new features
local snacks = require 'snacks'

-- LSP rename with Snacks integration
vim.keymap.set('n', '<leader>rn', function()
  snacks.rename.rename_file()
end, { desc = 'Rename File' })

-- Enhanced picker sources
vim.keymap.set('n', '<leader>fk', function()
  picker.keymaps()
end, { desc = 'Find Keymaps' })

-- LSP pickers

vim.keymap.set('n', '<leader>ls', function()
  picker.lsp_symbols()
end, { desc = 'LSP Document Symbols' })

vim.keymap.set('n', '<leader>lS', function()
  picker.lsp_workspace_symbols()
end, { desc = 'LSP Workspace Symbols' })

-- Project management
vim.keymap.set('n', '<leader>pp', function()
  picker.projects()
end, { desc = 'Find Projects' })

-- Fast file searching with smart defaults
vim.keymap.set('n', '<C-p>', function()
  picker.smart() -- Automatically chooses git_files or files
end, { desc = 'Smart File Search' })

vim.keymap.set('n', '<C-p><C-p>', function()
  picker.files { hidden = true }
end, { desc = 'Search All Files' })

vim.keymap.set('n', '<leader>tS', function()
  picker.pick()
end, { desc = 'Show all pickers' })

-- Optimized grep with word boundary
vim.keymap.set('n', '<C-f>', function()
  picker.grep()
end, { desc = 'Live Grep' })

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

-- Performance optimizations and enhanced autocmds
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    -- Enable word highlighting after startup for better performance
    if package.loaded['snacks'] and require('snacks').words then
      require('snacks').words.enable()
    end

    -- Auto-detect and change to project root (replaces vim-rooter)
    -- PERFORMANCE: Cache root finding to avoid repeated directory traversal
    local root_cache = {}
    local function find_root()
      local current_dir = vim.fn.expand '%:p:h'

      -- PERFORMANCE: Check cache first
      if root_cache[current_dir] then
        return
      end

      local patterns = { '.git', 'composer.json', 'package.json', 'pyproject.toml', 'Cargo.toml' }

      local function find_pattern_upward(dir, patterns)
        -- PERFORMANCE: Check cache for parent directories too
        if root_cache[dir] then
          return root_cache[dir]
        end

        for _, pattern in ipairs(patterns) do
          local path = dir .. '/' .. pattern
          if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
            root_cache[dir] = dir
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
        -- PERFORMANCE: Mark all intermediate directories as cached
        root_cache[current_dir] = root
      end
    end

    -- PERFORMANCE: Only run on first buffer enter, not every buffer switch
    local root_found = false
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      callback = function()
        if not root_found then
          find_root()
          root_found = true
        end
      end,
    })

    -- Run once on startup
    find_root()
    root_found = true

    -- Setup dashboard keybindings after startup
    if package.loaded['snacks'] and require('snacks').dashboard then
      vim.keymap.set('n', '<leader>D', function()
        require('snacks').dashboard()
      end, { desc = 'Dashboard' })
    end
  end,
})

-- Enhanced notification handling
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    -- Replace default vim.notify with Snacks notifier
    if package.loaded['snacks'] and require('snacks').notifier then
      vim.notify = require('snacks').notifier.notify
    end
  end,
})

-- Git integration enhancements
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  callback = function()
    -- Auto-enable git signs for git repositories
    if vim.fn.isdirectory '.git' == 1 and package.loaded['snacks'] then
      vim.defer_fn(function()
        -- Trigger git status refresh
        require('snacks').git.get_root()
      end, 100)
    end
  end,
})

-- Performance: Lazy load heavy features
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyDone',
  callback = function()
    -- Enable animations after all plugins are loaded
    if package.loaded['snacks'] then
      vim.g.snacks_animate = true
    end
  end,
})

-- Customize explorer highlight for hidden/ignored files
-- Make them less dimmed for better visibility
-- Uses shared color palette from core/colors.lua
local colors = require 'core.colors'

local function set_snacks_highlights()
  vim.api.nvim_set_hl(0, 'SnacksPickerPathHidden', { fg = colors.overlay1 })
  vim.api.nvim_set_hl(0, 'SnacksPickerPathIgnored', { fg = colors.overlay1 })
end

-- Set highlights on colorscheme change and initial load
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_snacks_highlights })
set_snacks_highlights()

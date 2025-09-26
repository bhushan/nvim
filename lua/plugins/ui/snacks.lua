require('snacks').setup {
  bigfile = { enabled = true }, -- Disable features on big files for performance
  quickfile = { enabled = true }, -- Fast file opening
  git = { enabled = true }, -- Git integration for root detection

  -- Enhanced development features
  animate = {
    enabled = true,
    duration = 20,
    fps = 60,
    easing = 'linear',
  },

  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, limit = 8 },
      { icon = ' ', title = 'Projects', section = 'projects', indent = 2, limit = 8 },
      { section = 'startup' },
    },
    preset = {
      header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]],
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files()' },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.picker.recent()' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.picker.grep()' },
        { icon = ' ', key = 'c', desc = 'Config', action = ':e $MYVIMRC' },
        { icon = ' ', key = 's', desc = 'Restore Session', action = ':SessionRestore' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
  },

  scratch = {
    enabled = true,
    win = {
      style = 'scratch',
      width = 100,
      height = 30,
      border = 'single',
    },
    name = function()
      -- Context-aware naming
      local git_branch = vim.fn.system('git branch --show-current 2>/dev/null'):gsub('\n', '')
      if git_branch and git_branch ~= '' then
        return 'scratch_' .. git_branch
      end
      return 'scratch_' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end,
    ft = function()
      if vim.bo.buftype == '' and vim.bo.filetype ~= '' then
        return vim.bo.filetype
      end
      return 'lua'
    end,
  },

  bufdelete = { enabled = true },

  input = {
    enabled = true,
    icon = ' ',
    icon_pos = 'left',
    prompt_pos = 'title',
    win = {
      relative = 'cursor',
      row = -3,
      col = 0,
      border = 'single',
    },
  },

  indent = {
    enabled = true,
    char = '│',
    blank = ' ',
    only_scope = false,
    only_current = false,
    hl = 'SnacksIndent',
    scope = {
      enabled = true,
      char = '│',
      underline = false,
      only_current = true,
      hl = 'SnacksIndentScope',
    },
    chunk = {
      enabled = true,
    },
  },

  scope = {
    enabled = true,
    keys = {
      jump = {
        ['[s'] = {
          desc = 'Previous Scope',
          fn = function()
            require('snacks').scope.jump(-1)
          end,
        },
        [']s'] = {
          desc = 'Next Scope',
          fn = function()
            require('snacks').scope.jump(1)
          end,
        },
      },
    },
  },

  zen = {
    enabled = true,
    toggles = {
      dim = true,
      git_signs = false,
      mini_diff_signs = false,
      diagnostics = false,
      inlay_hints = false,
    },
    show = {
      statusline = false,
      tabline = false,
    },
    win = {
      width = 0.8,
    },
  },

  dim = {
    enabled = true,
    scope = {
      min_size = 5,
      max_size = 20,
      siblings = true,
    },
    animate = {
      enabled = true,
      easing = 'outQuad',
      duration = 300,
    },
  },

  lazygit = {
    enabled = true,
    configure = true, -- Auto-configure theme
    win = {
      width = 0.9,
      height = 0.9,
      border = 'single',
    },
  },

  gitbrowse = { enabled = true },

  rename = { enabled = true },

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

  -- Toggle configurations with keybindings
  toggle = {
    map = vim.keymap.set,
    which_key = true,
    notify = true,
    icon = {
      enabled = ' ',
      disabled = ' ',
    },
    color = {
      enabled = 'green',
      disabled = 'red',
    },
  },
}

-- Setup picker keybindings for performance
local picker = require('snacks').picker

-- Toggle keybindings for all available toggles
local toggle = require('snacks').toggle

-- Animation toggle
vim.keymap.set('n', '<leader>ta', function()
  toggle.animate()
end, { desc = 'Toggle Animations' })

-- Diagnostics toggle
vim.keymap.set('n', '<leader>td', function()
  toggle.diagnostics()
end, { desc = 'Toggle Diagnostics' })

-- Dim toggle
vim.keymap.set('n', '<leader>tD', function()
  toggle.dim()
end, { desc = 'Toggle Dim' })

-- Indent guides toggle
vim.keymap.set('n', '<leader>ti', function()
  toggle.indent()
end, { desc = 'Toggle Indent Guides' })

-- Inlay hints toggle
vim.keymap.set('n', '<leader>th', function()
  toggle.inlay_hints()
end, { desc = 'Toggle Inlay Hints' })

-- Line numbers toggle
vim.keymap.set('n', '<leader>tl', function()
  toggle.line_number()
end, { desc = 'Toggle Line Numbers' })

-- Profiler toggle
vim.keymap.set('n', '<leader>tp', function()
  toggle.profiler()
end, { desc = 'Toggle Profiler' })

-- Profiler highlights toggle
vim.keymap.set('n', '<leader>tP', function()
  toggle.profiler_highlights()
end, { desc = 'Toggle Profiler Highlights' })

-- Scroll toggle
vim.keymap.set('n', '<leader>ts', function()
  toggle.scroll()
end, { desc = 'Toggle Smooth Scroll' })

-- TreeSitter toggle
vim.keymap.set('n', '<leader>tt', function()
  toggle.treesitter()
end, { desc = 'Toggle TreeSitter' })

-- Words toggle
vim.keymap.set('n', '<leader>tw', function()
  toggle.words()
end, { desc = 'Toggle LSP Words' })

-- Zen mode toggle
vim.keymap.set('n', '<leader>tz', function()
  toggle.zen()
end, { desc = 'Toggle Zen Mode' })

-- Zoom toggle
vim.keymap.set('n', '<leader>tZ', function()
  toggle.zoom()
end, { desc = 'Toggle Zoom Mode' })

-- Additional powerful keybindings for new features
local snacks = require 'snacks'

-- Dashboard
vim.keymap.set('n', '<leader>db', function()
  snacks.dashboard()
end, { desc = 'Dashboard' })

-- Scratch buffer management
vim.keymap.set('n', '<leader>ns', function()
  snacks.scratch()
end, { desc = 'New Scratch Buffer' })
vim.keymap.set('n', '<leader>ss', function()
  snacks.scratch.select()
end, { desc = 'Select Scratch Buffer' })

-- Buffer management
vim.keymap.set('n', '<leader>bd', function()
  snacks.bufdelete()
end, { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bD', function()
  snacks.bufdelete.all()
end, { desc = 'Delete All Buffers' })
vim.keymap.set('n', '<leader>bo', function()
  snacks.bufdelete.other()
end, { desc = 'Delete Other Buffers' })

-- Git integration
vim.keymap.set('n', '<leader>gb', function()
  snacks.git.blame_line()
end, { desc = 'Git Blame Line' })
vim.keymap.set('n', '<leader>gB', function()
  snacks.gitbrowse()
end, { desc = 'Git Browse' })
vim.keymap.set('n', '<leader>gg', function()
  snacks.lazygit()
end, { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>gf', function()
  snacks.lazygit.log_file()
end, { desc = 'Git File History' })
vim.keymap.set('n', '<leader>gl', function()
  snacks.lazygit.log()
end, { desc = 'Git Log' })

-- Scope navigation
vim.keymap.set('n', '[s', function()
  snacks.scope.jump(-1)
end, { desc = 'Previous Scope' })
vim.keymap.set('n', ']s', function()
  snacks.scope.jump(1)
end, { desc = 'Next Scope' })

-- Words/references
vim.keymap.set('n', '<leader>wr', function()
  snacks.words.jump(1)
end, { desc = 'Next Reference' })
vim.keymap.set('n', '<leader>wR', function()
  snacks.words.jump(-1)
end, { desc = 'Previous Reference' })

-- LSP rename with Snacks integration
vim.keymap.set('n', '<leader>rn', function()
  snacks.rename.rename_file()
end, { desc = 'Rename File' })

-- Notification management
vim.keymap.set('n', '<leader>nd', function()
  snacks.notifier.hide()
end, { desc = 'Dismiss Notifications' })
vim.keymap.set('n', '<leader>nh', function()
  snacks.notifier.show_history()
end, { desc = 'Notification History' })

-- Profiler (for performance debugging)
vim.keymap.set('n', '<leader>ps', function()
  snacks.profiler.scratch()
end, { desc = 'Profiler Scratch' })

-- Enhanced picker sources
vim.keymap.set('n', '<leader>fk', function()
  picker.keymaps()
end, { desc = 'Find Keymaps' })
vim.keymap.set('n', '<leader>fc', function()
  picker.commands()
end, { desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fh', function()
  picker.help()
end, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fm', function()
  picker.man()
end, { desc = 'Find Man Pages' })
vim.keymap.set('n', '<leader>fo', function()
  picker.vim_options()
end, { desc = 'Find Vim Options' })
vim.keymap.set('n', '<leader>fa', function()
  picker.autocmds()
end, { desc = 'Find Autocommands' })
vim.keymap.set('n', '<leader>fj', function()
  picker.jumps()
end, { desc = 'Find Jumps' })
vim.keymap.set('n', '<leader>fl', function()
  picker.loclist()
end, { desc = 'Find Location List' })
vim.keymap.set('n', '<leader>fq', function()
  picker.qflist()
end, { desc = 'Find Quickfix List' })

-- Git-specific pickers
vim.keymap.set('n', '<leader>gc', function()
  picker.git_commits()
end, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>gs', function()
  picker.git_status()
end, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gS', function()
  picker.git_stash()
end, { desc = 'Git Stash' })
vim.keymap.set('n', '<leader>go', function()
  picker.git_branches()
end, { desc = 'Git Branches' })

-- LSP pickers
vim.keymap.set('n', '<leader>lr', function()
  picker.lsp_references()
end, { desc = 'LSP References' })
vim.keymap.set('n', '<leader>ld', function()
  picker.lsp_definitions()
end, { desc = 'LSP Definitions' })
vim.keymap.set('n', '<leader>lt', function()
  picker.lsp_type_definitions()
end, { desc = 'LSP Type Definitions' })
vim.keymap.set('n', '<leader>li', function()
  picker.lsp_implementations()
end, { desc = 'LSP Implementations' })
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

-- Recent files for quick access
vim.keymap.set('n', '<leader>fr', function()
  picker.recent()
end, { desc = 'Recent Files' })

-- Fast buffer switching
vim.keymap.set('n', '<leader><space>', function()
  picker.buffers()
end, { desc = 'Switch Buffers' })

vim.keymap.set('n', '<leader>tS', function()
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

-- Performance optimizations and enhanced autocmds
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    -- Enable word highlighting after startup for better performance
    if package.loaded['snacks'] and require('snacks').words then
      require('snacks').words.enable()
    end

    -- Auto-detect and change to project root (replaces vim-rooter)
    local function find_root()
      local patterns = { '.git', 'package.json', 'composer.json', 'Makefile', 'README.md', 'pyproject.toml', 'Cargo.toml' }
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

    -- Setup dashboard keybindings after startup
    if package.loaded['snacks'] and require('snacks').dashboard then
      vim.keymap.set('n', '<leader>D', function()
        require('snacks').dashboard()
      end, { desc = 'Dashboard' })
    end
  end,
})

-- Enhanced scratch buffer autocmds
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_scratch',
  callback = function(ev)
    -- Enhanced scratch buffer settings
    vim.opt_local.wrap = false
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    vim.opt_local.cursorline = true

    -- Special keybindings for scratch buffers
    vim.keymap.set('n', '<leader>x', function()
      local content = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
      local code = table.concat(content, '\n')
      if vim.bo.filetype == 'lua' then
        -- Execute Lua code in scratch buffer
        local ok, result = pcall(loadstring(code))
        if ok and result then
          vim.notify('Executed: ' .. tostring(result), vim.log.levels.INFO)
        elseif not ok then
          vim.notify('Error: ' .. tostring(result), vim.log.levels.ERROR)
        end
      end
    end, { buffer = ev.buf, desc = 'Execute scratch buffer' })

    vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { buffer = ev.buf, desc = 'Save scratch buffer' })
  end,
})

-- Auto-save scratch buffers
vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'snacks_scratch' then
      -- Auto-save scratch buffers after 2 seconds of inactivity
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(vim.api.nvim_get_current_buf()) then
          vim.cmd 'silent! write'
        end
      end, 2000)
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

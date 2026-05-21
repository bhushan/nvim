require('snacks').setup {
  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
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
    },
  },

  notifier = {
    enabled = false, -- noice.nvim handles notifications
  },
  input = {
    enabled = true,
  },
  picker = {
    ui_select = true,
    sources = {
      explorer = {
        hidden = true,
        ignored = true,
        layout = {
          layout = {
            width = 0.4,
            position = 'right',
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

  zen = {
    enabled = true,
    toggles = {
      dim = false,
    },
    win = {
      backdrop = { transparent = false },
    },
  },
}

-- Setup picker keybindings - use lazy loading to avoid eager requires

-- LSP rename with Snacks integration
vim.keymap.set('n', '<leader>rn', function()
  require('snacks').rename.rename_file()
end, { desc = 'Rename File' })

-- Enhanced picker sources
vim.keymap.set('n', '<leader>fk', function()
  require('snacks').picker.keymaps()
end, { desc = 'Find Keymaps' })

-- LSP pickers
vim.keymap.set('n', '<leader>ls', function()
  require('snacks').picker.lsp_symbols()
end, { desc = 'LSP Document Symbols' })

vim.keymap.set('n', '<leader>lS', function()
  require('snacks').picker.lsp_workspace_symbols()
end, { desc = 'LSP Workspace Symbols' })

-- Project management
vim.keymap.set('n', '<leader>pp', function()
  require('snacks').picker.projects()
end, { desc = 'Find Projects' })

-- Fast file searching scoped to current project
vim.keymap.set('n', '<C-p>', function()
  require('snacks').picker.files()
end, { desc = 'Find Files' })

vim.keymap.set('n', '<C-p><C-p>', function()
  require('snacks').picker.files { hidden = true }
end, { desc = 'Search All Files' })

vim.keymap.set('n', '<leader>tS', function()
  require('snacks').picker.pick()
end, { desc = 'Show all pickers' })

-- Live grep (use leader key since C-f is now find-and-replace)
vim.keymap.set('n', '<leader>fg', function()
  require('snacks').picker.grep()
end, { desc = 'Live Grep' })

-- Terminal keybindings to match floaterm
vim.keymap.set('n', '`', function()
  require('snacks').terminal.toggle()
end, { desc = 'Toggle Terminal in normal mode', silent = true })
vim.keymap.set('t', '`', function()
  require('snacks').terminal.toggle()
end, { desc = 'Toggle Terminal in terminal mode', silent = true })

-- Explorer keybinding to match neotree
vim.keymap.set('n', '\\', function()
  require('snacks').explorer.open()
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

-- Auto-detect and change to project root on startup
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    local patterns = { '.git', 'composer.json', 'package.json', 'pyproject.toml', 'Cargo.toml' }
    local dir = vim.fn.expand '%:p:h'
    while dir ~= '/' do
      for _, pattern in ipairs(patterns) do
        if vim.uv.fs_stat(dir .. '/' .. pattern) then
          if dir ~= vim.fn.getcwd() then
            vim.cmd('cd ' .. dir)
          end
          return
        end
      end
      dir = vim.fn.fnamemodify(dir, ':h')
    end
  end,
})

vim.keymap.set('n', '<leader>D', function()
  require('snacks').dashboard()
end, { desc = 'Dashboard' })

vim.keymap.set('n', '<leader>z', function()
  require('snacks').zen()
end, { desc = 'Zen Mode' })

-- Customize explorer highlight for hidden/ignored files
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local colors = require 'core.colors'
    vim.api.nvim_set_hl(0, 'SnacksPickerPathHidden', { fg = colors.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerPathIgnored', { fg = colors.overlay1 })
  end,
})

-- Arctic Blue dashboard highlights
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local arctic = require('core.colors').arctic
    vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = arctic.ice })
    vim.api.nvim_set_hl(0, 'SnacksDashboardKey', { fg = arctic.amber, bold = true })
    vim.api.nvim_set_hl(0, 'SnacksDashboardDesc', { fg = '#a9b1d6' })
    vim.api.nvim_set_hl(0, 'SnacksDashboardIcon', { fg = arctic.teal })
    vim.api.nvim_set_hl(0, 'SnacksDashboardFooter', { fg = arctic.comment })
  end,
})

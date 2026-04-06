local function open_floating_grug_far(grug_opts)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local opts = vim.tbl_deep_extend('force', {
    windowCreationCommand = 'vsplit',
  }, grug_opts or {})

  require('grug-far').open(opts)

  vim.api.nvim_win_set_config(0, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = 'rounded',
    title = '  Find and Replace ',
    title_pos = 'center',
  })
end

return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup {
      transient = true,
      keymaps = {
        close = { n = '<Esc>', i = '<Esc><Esc>' },
        replace = { n = '<localleader>r', i = '<C-enter>' },
        openNextLocation = { n = '<C-j>' },
        openPrevLocation = { n = '<C-k>' },
      },
    }
  end,
  keys = {
    {
      '<C-f>',
      function()
        open_floating_grug_far()
      end,
      desc = 'Find and Replace',
    },
    {
      '<C-f>',
      function()
        open_floating_grug_far { visualSelectionUsage = 'prefill-search' }
      end,
      mode = 'v',
      desc = 'Find and Replace (selection)',
    },
    {
      '<C-f><C-f>',
      function()
        open_floating_grug_far { visualSelectionUsage = 'operate-within-range' }
      end,
      mode = 'v',
      desc = 'Find and Replace (within selection)',
    },
  },
}

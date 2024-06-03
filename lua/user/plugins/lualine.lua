require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    theme = {
      normal = {
        a = '',
        b = '',
        c = '',
      },
      terminal = {
        a = '',
        b = '',
        c = '',
      },
    },
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      function()
        return '🛠 ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.get_active_clients())) or '')
      end,

      {
        'diff',
        symbols = { added = '  ', modified = '  ', removed = '  ' },
      },
      {
        'diagnostics',
        symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' },
      },
    },
    lualine_c = {
      'filename',
    },
    lualine_x = {
      {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = '#ff9e64' },
      },
    },
    lualine_y = {
      'filetype',
      'encoding',
      'fileformat',
      '(vim.bo.expandtab and "␠ " or "⇥ ") .. vim.bo.shiftwidth',
    },
    lualine_z = {
      'searchcount',
      'selectioncount',
      'location',
      'progress',
    },
  },
}

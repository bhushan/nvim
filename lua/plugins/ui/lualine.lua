local custom_theme = {
  normal = {
    a = { bg = '#282a36', gui = 'bold' },
    b = { bg = '#282a36' },
    c = { bg = '#282a36' },
  },
  insert = {
    a = { bg = '#282a36', gui = 'bold' },
    b = { bg = '#282a36' },
    c = { bg = '#282a36' },
  },
  visual = {
    a = { bg = '#282a36', gui = 'bold' },
    b = { bg = '#282a36' },
    c = { bg = '#282a36' },
  },
  replace = {
    a = { bg = '#282a36', gui = 'bold' },
    b = { bg = '#282a36' },
    c = { bg = '#282a36' },
  },
  command = {
    a = { bg = '#282a36', gui = 'bold' },
    b = { bg = '#282a36' },
    c = { bg = '#282a36' },
  },
  inactive = {
    a = { bg = '#282a36' },
    b = { bg = '#282a36' },
    c = { bg = '#282a36' },
  },
}

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    theme = custom_theme,
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      function()
        return '🛠 ' .. tostring(#vim.lsp.get_clients())
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
      function()
        return (vim.bo.expandtab and '␠ ' or '⇥ ') .. vim.bo.shiftwidth
      end,
    },
    lualine_z = {
      'searchcount',
      'selectioncount',
      'location',
      'progress',
    },
  },
}

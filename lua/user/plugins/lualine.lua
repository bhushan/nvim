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
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
      function()
        return '⚙ ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.get_active_clients())) or '')
      end,
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
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

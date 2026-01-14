-- GitHub Dimmed theme for lualine (see colors/github-dimmed.md)
local colors = {
  bg = '#22272e',
  bg_hl = '#2d333b',
  fg = '#adbac7',
  fg_muted = '#768390',
  blue = '#539bf5',
  green = '#57ab5a',
  purple = '#b083f0',
  orange = '#e0823d',
  red = '#f47067',
  yellow = '#c69026',
}

local custom_theme = {
  normal = {
    a = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg_hl, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_muted },
  },
  insert = {
    a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg_hl, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_muted },
  },
  visual = {
    a = { bg = colors.purple, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg_hl, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_muted },
  },
  replace = {
    a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg_hl, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_muted },
  },
  command = {
    a = { bg = colors.orange, fg = colors.bg, gui = 'bold' },
    b = { bg = colors.bg_hl, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg_muted },
  },
  inactive = {
    a = { bg = colors.bg, fg = colors.fg_muted },
    b = { bg = colors.bg, fg = colors.fg_muted },
    c = { bg = colors.bg, fg = colors.fg_muted },
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
        symbols = { added = '  ', modified = '  ', removed = '  ' },
      },
      {
        'diagnostics',
        symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' },
      },
    },
    lualine_c = {
      'filename',
    },
    lualine_x = {
      {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = colors.orange },
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

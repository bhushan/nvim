-- Catppuccin Mocha theme for lualine
-- Uses shared color palette from core/colors.lua
local colors = require 'core.colors'

local custom_theme = {
  normal = {
    a = { bg = colors.blue, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  insert = {
    a = { bg = colors.green, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  visual = {
    a = { bg = colors.mauve, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  replace = {
    a = { bg = colors.red, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  command = {
    a = { bg = colors.peach, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  inactive = {
    a = { bg = colors.base, fg = colors.subtext0 },
    b = { bg = colors.base, fg = colors.subtext0 },
    c = { bg = colors.base, fg = colors.subtext0 },
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
        return tostring(#vim.lsp.get_clients())
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
        color = { fg = colors.peach },
      },
    },
    lualine_y = {
      'filetype',
      'encoding',
      'fileformat',
      function()
        return (vim.bo.expandtab and ' ' or ' ') .. vim.bo.shiftwidth
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

-- Arctic Blue lualine — stream-optimized statusline
-- Uses shared color palette from core/colors.lua
local colors = require 'core.colors'
local arctic = colors.arctic

local custom_theme = {
  normal = {
    a = { bg = arctic.ice, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  insert = {
    a = { bg = arctic.mint, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  visual = {
    a = { bg = arctic.purple, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  replace = {
    a = { bg = arctic.rose, fg = colors.base, gui = 'bold' },
    b = { bg = colors.surface0, fg = colors.text },
    c = { bg = colors.base, fg = colors.subtext0 },
  },
  command = {
    a = { bg = arctic.amber, fg = colors.base, gui = 'bold' },
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
      -- Macro recording indicator (visible to stream viewers)
      {
        function()
          local reg = vim.fn.reg_recording()
          if reg ~= '' then
            return '󰑋 REC @' .. reg
          end
          return ''
        end,
        color = { fg = arctic.rose, gui = 'bold' },
      },
      -- Active LSP server name
      {
        function()
          local clients = vim.lsp.get_clients { bufnr = 0 }
          if #clients == 0 then
            return ''
          end
          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end
          return '  ' .. table.concat(names, ', ')
        end,
        color = { fg = arctic.teal },
      },
      {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = arctic.amber },
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

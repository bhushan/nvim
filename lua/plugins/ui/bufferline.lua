-- Buffer tabs — visual buffer management for streams
-- Shows all open buffers at the top, Arctic Blue themed
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local colors = require 'core.colors'
    local arctic = colors.arctic

    require('bufferline').setup {
      options = {
        mode = 'buffers',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'thin',
        always_show_bufferline = false, -- only show when 2+ buffers
        offsets = {
          {
            filetype = 'snacks_picker',
            text = 'Explorer',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
      highlights = {
        fill = { bg = colors.mantle },
        background = { fg = colors.overlay0, bg = colors.mantle },
        buffer_selected = { fg = colors.text, bg = colors.base, bold = true },
        buffer_visible = { fg = colors.subtext0, bg = colors.mantle },
        close_button_selected = { fg = arctic.rose, bg = colors.base },
        indicator_selected = { fg = arctic.ice, bg = colors.base },
        modified = { fg = arctic.amber, bg = colors.mantle },
        modified_selected = { fg = arctic.amber, bg = colors.base },
        modified_visible = { fg = arctic.amber, bg = colors.mantle },
        separator = { fg = colors.mantle, bg = colors.mantle },
        separator_selected = { fg = colors.mantle, bg = colors.base },
        separator_visible = { fg = colors.mantle, bg = colors.mantle },
        tab = { fg = colors.overlay0, bg = colors.mantle },
        tab_selected = { fg = colors.text, bg = colors.base, bold = true },
        tab_separator = { fg = colors.mantle, bg = colors.mantle },
        tab_separator_selected = { fg = arctic.ice, bg = colors.base },
        diagnostic_selected = { bold = true },
        error_selected = { fg = arctic.rose, bg = colors.base, bold = true },
        error_diagnostic_selected = { fg = arctic.rose, bg = colors.base, bold = true },
        warning_selected = { fg = arctic.amber, bg = colors.base, bold = true },
        warning_diagnostic_selected = { fg = arctic.amber, bg = colors.base, bold = true },
      },
    }
  end,
}

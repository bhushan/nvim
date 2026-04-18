-- Winbar breadcrumbs — shows file > class > method context
-- Uses nvim-navic for LSP breadcrumb data, barbecue for the UI
return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local colors = require 'core.colors'
    local arctic = colors.arctic

    require('barbecue').setup {
      theme = {
        normal = { fg = colors.subtext0, bg = colors.base },
        dirname = { fg = colors.overlay1 },
        basename = { fg = colors.text, bold = true },
        context = { fg = colors.subtext1 },
        context_file = { fg = arctic.teal },
        context_module = { fg = arctic.purple },
        context_namespace = { fg = arctic.purple },
        context_package = { fg = arctic.purple },
        context_class = { fg = arctic.teal },
        context_method = { fg = arctic.purple },
        context_property = { fg = colors.subtext1 },
        context_field = { fg = colors.subtext1 },
        context_constructor = { fg = arctic.teal },
        context_enum = { fg = arctic.teal },
        context_interface = { fg = arctic.teal },
        context_function = { fg = arctic.purple },
        context_variable = { fg = colors.text },
        context_constant = { fg = arctic.rose },
        context_string = { fg = arctic.amber },
        context_number = { fg = arctic.rose },
        context_boolean = { fg = arctic.rose },
        context_array = { fg = arctic.teal },
        context_object = { fg = arctic.teal },
        context_key = { fg = arctic.ice },
        context_null = { fg = arctic.rose },
        context_enum_member = { fg = arctic.rose },
        context_struct = { fg = arctic.teal },
        context_event = { fg = arctic.amber },
        context_operator = { fg = colors.overlay2 },
        context_type_parameter = { fg = arctic.teal },
        separator = { fg = colors.overlay0 },
        modified = { fg = arctic.amber },
        ellipsis = { fg = colors.overlay0 },
      },
      show_dirname = false,
      show_modified = true,
      exclude_filetypes = { 'snacks_dashboard', 'snacks_picker', 'toggleterm', 'help', 'lazy', 'mason' },
    }
  end,
}

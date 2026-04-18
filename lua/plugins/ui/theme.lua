-- Arctic Blue theme — custom Catppuccin Mocha overrides
-- Base: Catppuccin Mocha | Accents: Arctic Blue palette from core/colors.lua
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    local colors = require 'core.colors'
    local arctic = colors.arctic

    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = false,
      dim_inactive = {
        enabled = false,
      },
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = { 'bold' },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { 'bold' },
        properties = {},
        types = { 'bold' },
        operators = {},
      },
      custom_highlights = function()
        return {
          -- Syntax: keywords
          ['@keyword'] = { fg = arctic.ice },
          ['@keyword.function'] = { fg = arctic.ice, bold = true },
          ['@keyword.return'] = { fg = arctic.ice, bold = true },
          ['@keyword.operator'] = { fg = arctic.ice },
          ['@conditional'] = { fg = arctic.ice, italic = true },
          ['@repeat'] = { fg = arctic.ice, italic = true },
          ['@include'] = { fg = arctic.ice },
          ['@exception'] = { fg = arctic.ice },
          Keyword = { fg = arctic.ice },
          Statement = { fg = arctic.ice },
          Conditional = { fg = arctic.ice, italic = true },
          Repeat = { fg = arctic.ice, italic = true },

          -- Syntax: functions
          ['@function'] = { fg = arctic.purple },
          ['@function.call'] = { fg = arctic.purple },
          ['@function.method'] = { fg = arctic.purple },
          ['@function.method.call'] = { fg = arctic.purple },
          ['@function.builtin'] = { fg = arctic.mint },
          ['@constructor'] = { fg = arctic.teal },
          Function = { fg = arctic.purple },

          -- Syntax: strings
          ['@string'] = { fg = arctic.amber },
          ['@string.escape'] = { fg = arctic.rose },
          ['@string.regex'] = { fg = arctic.rose },
          String = { fg = arctic.amber },

          -- Syntax: types
          ['@type'] = { fg = arctic.teal, bold = true },
          ['@type.builtin'] = { fg = arctic.teal },
          ['@type.definition'] = { fg = arctic.teal, bold = true },
          Type = { fg = arctic.teal },

          -- Syntax: variables and properties
          ['@variable'] = { fg = colors.text },
          ['@variable.builtin'] = { fg = arctic.rose, italic = true },
          ['@variable.parameter'] = { fg = colors.subtext1 },
          ['@property'] = { fg = colors.subtext1 },
          ['@field'] = { fg = colors.subtext1 },

          -- Syntax: constants and numbers
          ['@constant'] = { fg = arctic.rose },
          ['@constant.builtin'] = { fg = arctic.rose, bold = true },
          ['@number'] = { fg = arctic.rose },
          ['@boolean'] = { fg = arctic.rose, bold = true },
          Number = { fg = arctic.rose },
          Boolean = { fg = arctic.rose, bold = true },
          Constant = { fg = arctic.rose },

          -- Syntax: comments
          ['@comment'] = { fg = arctic.comment, italic = true },
          Comment = { fg = arctic.comment, italic = true },

          -- Syntax: operators and punctuation
          ['@operator'] = { fg = colors.overlay2 },
          ['@punctuation.bracket'] = { fg = colors.overlay2 },
          ['@punctuation.delimiter'] = { fg = colors.overlay2 },
          Operator = { fg = colors.overlay2 },

          -- Syntax: tags (HTML/JSX)
          ['@tag'] = { fg = arctic.rose },
          ['@tag.attribute'] = { fg = arctic.purple },
          ['@tag.delimiter'] = { fg = colors.overlay2 },

          -- UI: cursor and selection
          CursorLine = { bg = arctic.cursorline },
          CursorLineNr = { fg = arctic.ice, bold = true },
          Visual = { bg = arctic.visual },
          LineNr = { fg = colors.surface2 },

          -- UI: search
          Search = { bg = '#3d59a1', fg = colors.text },
          IncSearch = { bg = arctic.amber, fg = colors.base },
          CurSearch = { bg = arctic.amber, fg = colors.base, bold = true },

          -- UI: pmenu (completion popup)
          Pmenu = { bg = colors.mantle },
          PmenuSel = { bg = arctic.visual, bold = true },
          PmenuSbar = { bg = colors.surface0 },
          PmenuThumb = { bg = colors.surface2 },

          -- UI: floating windows
          FloatBorder = { fg = arctic.ice, bg = colors.mantle },
          NormalFloat = { bg = colors.mantle },

          -- UI: diagnostics
          DiagnosticError = { fg = arctic.rose },
          DiagnosticWarn = { fg = arctic.amber },
          DiagnosticInfo = { fg = arctic.ice },
          DiagnosticHint = { fg = arctic.teal },

          -- UI: git signs
          GitSignsAdd = { fg = arctic.teal },
          GitSignsChange = { fg = arctic.amber },
          GitSignsDelete = { fg = arctic.rose },

          -- UI: indent guides
          IblIndent = { fg = arctic.cursorline },
          IblScope = { fg = arctic.teal },

          -- UI: treesitter context
          TreesitterContext = { bg = arctic.cursorline },
          TreesitterContextLineNumber = { fg = arctic.ice },
        }
      end,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        mason = true,
        which_key = true,
        snacks = true,
        noice = true,
        indent_blankline = {
          enabled = true,
          scope_color = 'teal',
        },
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = false,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}

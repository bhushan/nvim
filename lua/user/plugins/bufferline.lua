require("bufferline").setup({
  options = {
    indicator = {
      icon = " ",
    },
    show_close_icon = false,
    tab_size = 0,
    max_name_length = 25,
    offsets = {
      {
        filetype = "NvimTree",
        text = "  Files",
        highlight = "CursorLineNr",
        text_align = "left",
      },
    },
    separator_style = "slant",
    modified_icon = "",
    custom_areas = {
      left = function()
        return {
          { text = "    ", fg = "#8fff6d" },
        }
      end,
    },
  },
  highlights = {
    fill = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    background = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    tab = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    tab_close = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    close_button = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
      -- fg = { attribute = 'fg', highlight = 'CursorLineNrNonText' },
    },
    close_button_visible = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
      fg = { attribute = "fg", highlight = "CursorLineNrNonText" },
    },
    -- close_button_selected = {
    --   fg = { attribute = 'fg', highlight = 'CursorLineNrNonText' },
    -- },
    buffer_visible = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    modified = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    modified_visible = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    duplicate = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    duplicate_visible = {
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    separator = {
      fg = { attribute = "bg", highlight = "CursorLineNr" },
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
    separator_selected = {
      fg = { attribute = "bg", highlight = "CursorLineNr" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    separator_visible = {
      fg = { attribute = "bg", highlight = "CursorLineNr" },
      bg = { attribute = "bg", highlight = "CursorLineNr" },
    },
  },
})

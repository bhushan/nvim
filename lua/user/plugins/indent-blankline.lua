require("indent_blankline").setup({
  char = "┊",
  show_trailing_blankline_indent = false,
  filetype_exclude = {
    "help",
    "terminal",
    "dashboard",
    "packer",
    "mason",
    "NvimTree",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
  },
})

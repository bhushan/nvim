vim.cmd("colorscheme dracula")

-- Float term border colors changed to same to make it transparent
vim.api.nvim_set_hl(0, "FloatermBorder", {
  bg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
  fg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
})

-- Floaterm terminal colors
vim.api.nvim_set_hl(0, "Floaterm", {
  bg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
  fg = vim.api.nvim_get_hl_by_name("CursorLine", true).foreground,
})

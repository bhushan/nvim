vim.cmd("colorscheme dracula")

-- Float term border colors changed to same to make it transparent
vim.api.nvim_set_hl(0, "FloatermBorder", {
  bg = vim.api.nvim_get_hl_by_name("Visual", true).background,
  fg = vim.api.nvim_get_hl_by_name("Visual", true).background,
})

-- Floaterm terminal colors
vim.api.nvim_set_hl(0, "Floaterm", {
  bg = vim.api.nvim_get_hl_by_name("Visual", true).background,
  fg = vim.api.nvim_get_hl_by_name("Visual", true).foreground,
})

vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", {
  fg = "#282A36",
})

vim.api.nvim_set_hl(0, "BufferLineSeparator", {
  fg = "#282A36",
})

vim.api.nvim_set_hl(0, "BufferLineFill", {
  bg = "#282A36",
})

vim.api.nvim_set_hl(0, "NvimTreeNormal", {
  bg = "#282A36",
  fg = "#ffffff",
})

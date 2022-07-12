-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

local colors = vim.api.nvim_get_hl_by_name("Normal", true)
local bg = string.format("#%06x", colors.background) -- convert decimal number to 6 digit hexadecimal color code

gitsigns.setup()

vim.cmd("highlight GitSignsDelete guibg=" .. bg)

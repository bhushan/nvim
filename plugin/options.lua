local o = vim.o
local g = vim.g
local opt = vim.opt

vim.cmd("filetype plugin indent on")

o.fileencoding = "utf-8" -- file encoding

vim.opt.belloff = "all" -- never ring the bell for any reason

-- markdown file syntax highlight support
g.markdown_fenced_languages = {
  "html",
  "css",
  "scss",
  "sass",
  "javascript",
  "js=javascript",
  "json=javascript",
  "typescript=javascript",
  "ts=javascript",
  "php",
  "c",
  "cpp",
  "java",
  "xml",
  "vim",
  "yaml",
  "lua",
  "sh",
  "bash=sh",
}

opt.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- Let the user decide about the autocomplete

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append("c")

-- show whitespaces correctly
vim.o.list = true
vim.opt.listchars = {
  nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = "▷⋯", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- move cursor to next line when line ends
o.whichwrap = "b,s,<,>,[,],h,l"

-- split management
o.splitbelow = true
o.splitright = true

-- 3: always and ONLY the last window
-- 0: disable
o.laststatus = 0

vim.opt.termguicolors = true -- use 256 colors when possible

o.showtabline = 1 -- disable tabs at the top
o.showmode = false

o.backup = false
o.writebackup = false

o.updatetime = 50 -- vim updatetime for UI

o.clipboard = "unnamedplus" -- universal clipboard

o.hlsearch = true -- highlight search
o.ignorecase = true -- always do a case-insensitive search
o.smartcase = true -- override ignorecase if uppercase chars present
o.incsearch = true -- highlight matches while searching

o.scrolloff = 8 -- start scrolling window before 8 lines left
o.sidescrolloff = 8

o.mouse = "a" -- enable mouse

vim.wo.wrap = false -- dont wrap lines
vim.wo.number = true -- show line numbers on gutter line
vim.wo.relativenumber = true -- relative line numbers on gutter line
vim.wo.cursorline = true -- highlight currently selected line

o.tabstop = 2
vim.bo.tabstop = 2
o.softtabstop = 2
vim.bo.softtabstop = 2
o.shiftwidth = 2
vim.bo.shiftwidth = 2
o.autoindent = true
vim.bo.autoindent = true

-- convert tabs to spaces
o.expandtab = true
vim.bo.expandtab = true

vim.opt.dictionary:append("/usr/share/dict/words")

-- update diagnostics icons
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = "",
  })
end

local colors = vim.api.nvim_get_hl_by_name("Normal", true)
local bg = string.format("#%06x", colors.background) -- convert decimal number to 6 digit hexadecimal color code

vim.cmd("highlight NonText guibg=" .. bg .. " guifg=" .. bg)

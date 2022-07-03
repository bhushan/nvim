local o = vim.o
local g = vim.g
local opt = vim.opt

vim.cmd("filetype plugin indent on")

o.fileencoding = "utf-8" -- file encoding

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
vim.o.listchars = "tab:▸ ,trail:·"

-- move cursor to next line when line ends
o.whichwrap = "b,s,<,>,[,],h,l"

-- split management
o.splitbelow = true
o.splitright = true

o.laststatus = 3 -- 3: always and ONLY the last window

vim.opt.termguicolors = true -- use 256 colors when possible

o.showtabline = 1 -- disable tabs at the top
o.showmode = false

o.backup = false
o.writebackup = false

o.updatetime = 300 -- vim updatetime for UI

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

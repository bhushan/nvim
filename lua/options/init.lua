vim.cmd("filetype plugin indent on")
-- vim.o.shortmess = vim.o.shortmess .. "c"
-- vim.o.hidden = true

vim.o.fileencoding = "utf-8" -- file encoding

-- show whitespaces correctly
vim.o.list = true
-- eol:$,tab:>-,trail:~,extends:>,precedes:<
vim.o.listchars = "trail:•"

-- move cursor to next line when line ends
vim.o.whichwrap = "b,s,<,>,[,],h,l"

-- split management
vim.o.splitbelow = true
vim.o.splitright = true

vim.opt.termguicolors = true -- use 256 colors when possible

vim.o.showtabline = 1 -- disable tabs at the top
vim.o.showmode = false

vim.o.backup = false
vim.o.writebackup = false

vim.o.updatetime = 300 -- vim updatetime for UI

vim.o.clipboard = "unnamedplus" -- universal clipboard

vim.o.hlsearch = true -- highlight search
vim.o.ignorecase = true -- always do a case-insensitive search
vim.o.smartcase = true -- override ignorecase if uppercase chars present
vim.o.incsearch = true -- highlight matches while searching

vim.o.scrolloff = 3 -- start scrolling window before 3 lines left
vim.o.sidescrolloff = 5

vim.o.mouse = "a" -- enable mouse

vim.wo.wrap = false -- dont wrap lines
vim.wo.number = true -- show line numbers on gutter line
vim.wo.relativenumber = true -- relative line numbers on gutter line
vim.wo.cursorline = false -- highlight currently selected line
vim.wo.signcolumn = "yes"

vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.bo.softtabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.autoindent = true
vim.bo.autoindent = true

-- convert tabs to spaces
vim.o.expandtab = true
vim.bo.expandtab = true

-- Disable various builtin plugins in Vim that bog down speed
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1

vim.opt.dictionary:append("/usr/share/dict/words")

-- update diagnostics icons
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

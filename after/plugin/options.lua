local opt = vim.opt

opt.fileencoding = "utf-8" -- file encoding

opt.belloff = "all" -- never ring the bell for any reason

-- opt.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- Let the user decide about the autocomplete

-- -- Don't show the dumb matching stuff.
-- vim.opt.shortmess:append("c")

-- show whitespaces correctly
opt.list = true
opt.listchars = {
    nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8)
    extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB)
    precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB)
    tab = "▷⋯", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF)
    trail = "•", -- BULLET (U+2022)
}
opt.fillchars = {
    diff = "∙", -- BULLET OPERATOR (U+2219)
    eob = " ", -- NO-BREAK SPACE (U+00A0) to suppress ~ at EndOfBuffer
    fold = "·", -- MIDDLE DOT (U+00B7)
    vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503)
}

-- move cursor to next line when line ends
opt.whichwrap = "b,s,<,>,[,],h,l"

-- split management
opt.splitbelow = true
opt.splitright = true

-- 3: always and ONLY the last window
-- 0: disable
opt.laststatus = 3

opt.termguicolors = true -- use terminal colors

-- o.showtabline = 1 -- disable tabs at the top
-- o.showmode = false

opt.updatetime = 50 -- vim updatetime for UI

opt.clipboard = "unnamedplus" -- universal clipboard

opt.hlsearch = false -- highlight search
opt.ignorecase = true -- always do a case-insensitive search
opt.smartcase = true -- override ignorecase if uppercase chars present
opt.incsearch = true -- highlight matches while searching

opt.scrolloff = 8 -- start scrolling window before 8 lines left
opt.sidescrolloff = 8

opt.mouse = "a" -- enable mouse

opt.wrap = false -- dont wrap lines
opt.number = true -- show line numbers on gutter line
opt.relativenumber = true -- relative line numbers on gutter line
-- opt.cursorline = true -- highlight currently selected line
opt.signcolumn = "yes:2" -- always have gutter padding

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

opt.expandtab = true -- convert tabs to spaces

opt.wildmode = "longest:full,full" -- complete first longest common match only in command mode

opt.dictionary:append("/usr/share/dict/words")

opt.confirm = true -- confirm to save buffer instead of showing error on :q

opt.undofile = true -- keep persistent undo history
opt.backup = true -- backup files whenever you save it
opt.backupdir:remove(".") -- remove current directory form list to store backup

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

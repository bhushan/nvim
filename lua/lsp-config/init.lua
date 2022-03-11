local lspconfig = require("lspconfig")

-- Vimscript / VimL
lspconfig.vimls.setup({})

-- Javascript/Typescript
require("lspconfig").tsserver.setup({})

-- PHP
lspconfig.intelephense.setup({})

-- Vue
lspconfig.vuels.setup({})

-- Yaml
lspconfig.yamlls.setup({})

-- Json
lspconfig.jsonls.setup({})

-- Html
lspconfig.html.setup({
    filetypes = { "html", "blade" },
})

-- Tailwind
lspconfig.tailwindcss.setup({})

-- Keymaps
local map = vim.api.nvim_set_keymap

local opt = { noremap = true, silent = true }

map("n", "K", ":lua vim.lsp.buf.hover()<cr>", opt)
map("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<cr>", opt)

map("n", "grr", ":lua vim.lsp.buf.rename()<cr>", opt)
map("n", "gd", ":vsplit<cr>:lua vim.lsp.buf.definition()<cr>", opt)
map("n", "gr", ":lua vim.lsp.buf.references()<cr>", opt)

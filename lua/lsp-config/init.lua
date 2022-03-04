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

map("n", "<leader>irr", ":lua vim.lsp.buf.rename()<cr>", opt)
map("n", "<leader>ig", ":lua vim.lsp.buf.definition()<cr>", opt)
map("n", "<leader>iv", ":vsplit<cr>:lua vim.lsp.buf.definition()<cr>", opt)
map("n", "<leader>id", ":lua vim.lsp.buf.declaration()<cr>", opt)
map("n", "<leader>ir", ":lua vim.lsp.buf.references()<cr>", opt)
map("n", "<leader>ii", ":lua vim.lsp.buf.implementation()<cr>", opt)
map(
    "n",
    "<leader>ie",
    ":lua vim.lsp.diagnostic.show_line_diagnostics()<cr>",
    opt
)

map("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<cr>", opt)
map("n", "<C-n>", ":lua vim.lsp.diagnostic.goto_prev()<cr>", opt)
map("n", "<C-p>", ":lua vim.lsp.diagnostic.goto_next()<cr>", opt)

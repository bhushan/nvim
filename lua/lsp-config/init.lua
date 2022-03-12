require("lsp-config.cmp-config")
require("lsp-config.lspsaga-config")

local lspconfig = require("lspconfig")

-- PHP
-- local lsp_symbols =
--     {
--         Text = "   (Text) ",
--         Method = "   (Method)",
--         Function = "   (Function)",
--         Constructor = "   (Constructor)",
--         Field = " ﴲ  (Field)",
--         Variable = "[] (Variable)",
--         Class = "   (Class)",
--         Interface = " ﰮ  (Interface)",
--         Module = "   (Module)",
--         Property = " 襁 (Property)",
--         Unit = "   (Unit)",
--         Value = "   (Value)",
--         Enum = " 練 (Enum)",
--         Keyword = "   (Keyword)",
--         Snippet = "   (Snippet)",
--         Color = "   (Color)",
--         File = "   (File)",
--         Reference = "   (Reference)",
--         Folder = "   (Folder)",
--         EnumMember = "   (EnumMember)",
--         Constant = " ﲀ  (Constant)",
--         Struct = " ﳤ  (Struct)",
--         Event = "   (Event)",
--         Operator = "   (Operator)",
--         TypeParameter = "   (TypeParameter)",
--     }, require("lspconfig").intelephense.setup({})

-- HTML
lspconfig.html.setup({})

-- CSS LSP
lspconfig.cssls.setup({})

-- Javascript/Typescript
lspconfig.tsserver.setup({})

-- PHP
lspconfig.intelephense.setup({})

-- Vimscript / VimL
lspconfig.vimls.setup({})

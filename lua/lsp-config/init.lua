require("lsp-config.cmp-config")
require("lsp-config.lspsaga-config")

local lspconfig = require("lspconfig")

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

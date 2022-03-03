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

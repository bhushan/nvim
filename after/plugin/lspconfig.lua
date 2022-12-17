local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
local status_ok, mason = pcall(require, "mason")
local masonconfig_status_ok, masonconfig = pcall(require, "mason-lspconfig")
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok or not masonconfig_status_ok or not lspconfig_status_ok or not cmp_nvim_lsp_status_ok then
    return
end

-- Setup mason so it can manage external tooling
mason.setup()

-- Enable the following language servers
local servers = { "html", "cssls", "tsserver", "sumneko_lua", "intelephense" }

-- Ensure the servers above are installed
masonconfig.setup({
    ensure_installed = servers,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        -- on_attach = on_attach,
        capabilities = capabilities,
    })
end

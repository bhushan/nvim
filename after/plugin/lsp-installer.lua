-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
    return
end

lsp_installer.setup({
    automatic_installation = true,
    ui = {
        border = "single",
        icons = {
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
})

-- hacky way to add border on LspInfo command
local win = require("lspconfig.ui.windows")
local _default_opts = win.default_opts

win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = "single"
    return opts
end

local servers = {
    "html",
    "cssls",
    "tsserver",
    "ccls",
    "intelephense",
    "sumneko_lua",
    "emmet_ls",
    "jsonls",
    "marksman",
    "jdtls",
}

for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)

    if server_is_found then
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

        lspconfig[server.name]:setup({
            capabilities = capabilities,
        })
    end
end

-- Use a protected require call (pcall) so we don't error out on first use
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
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
}

-- Ensure installed
for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
        print("Installing " .. name)
        server:install()
    end
end

-- Enable snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
    return {
        capabilities = capabilities,
    }
end

lsp_installer.on_server_ready(function(server)
    local config = make_config()

    -- language specific config
    if server.name == "tsserver" then
        config.filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        }
    end

    if server.name == "emmet_ls" then
        config.filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
        }
    end

    if server.name == "sumneko_lua" then
        config.settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim", "use", "packer_plugins" },
                },
            },
        }
    end

    server:setup(config)
end)

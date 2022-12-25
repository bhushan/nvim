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
local servers = { "html", "cssls", "jsonls", "tsserver", "sumneko_lua", "intelephense" }

-- Ensure the servers above are installed
masonconfig.setup({
    ensure_installed = servers,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
end

local on_attach = function(server, bufnr)
    print(server.name .. " LSP attached to buffer number: " .. bufnr)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    map("n", "gr", ":Telescope lsp_references<CR>")
    map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    map("n", "<leader>k", "<cmd>lua vim.diagnostic.open_float()<CR>")
end

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

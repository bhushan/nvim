-- Setup Mason to automatically install LSP servers
require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
end

local on_attach = function(server, bufnr)
  -- needed this to show code action menu
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  map("n", "<Leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
  map("n", "gr", "<cmd>Telescope lsp_references<CR>")
  map("n", "grr", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", "gs", "<cmd>Telescope lsp_document_symbols<CR>")
  map("n", "gS", "<cmd>Telescope lsp_workspace_symbols<CR>")

  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- PHP LSP
require("lspconfig").intelephense.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Lua LSP
require("lspconfig").lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Vue, JavaScript, TypeScript, try for few days
require("lspconfig").volar.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
  -- This drastically improves the responsiveness of diagnostic updates on change
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- Tailwind CSS
require("lspconfig").tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- JSON
require("lspconfig").jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
})

-- for formatting different files
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js" })
      end,
    }),
    require("null-ls").builtins.diagnostics.trail_space.with({ disabled_filetypes = { "NvimTree" } }),
    require("null-ls").builtins.formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js" })
      end,
    }),
    require("null-ls").builtins.formatting.prettierd,
  },
})

require("mason-null-ls").setup({ automatic_installation = true })

-- Commands
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ async = true })
end, {})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = true,
  },
})

-- Sign configuration
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

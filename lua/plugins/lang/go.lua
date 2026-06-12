--- Go Language Support Plugins
--- Provides struct tag editing, interface implementation, and error handling helpers
--- Command-driven on purpose: adds no keybindings
--- @module plugins.lang.go

return {
  --- Lightweight Go development helpers built on gomodifytags, impl, and iferr
  --- All tools are auto-installed via mason-tool-installer (see plugins/lsp/lspconfig.lua)
  ---
  --- Commands:
  --- - :GoTagAdd json       Add json tags to the struct under cursor (any tag name works)
  --- - :GoTagRm json        Remove json tags from the struct under cursor
  --- - :GoImpl io.Writer    Generate method stubs for an interface on the receiver under cursor
  --- - :GoIfErr             Insert if err != nil block for the function under cursor
  --- - :GoMod tidy          Run go mod commands without leaving the editor
  --- - :GoGenerate          Run go generate
  ---
  --- LSP (gopls), formatting (goimports + gofumpt), and diagnostics (staticcheck)
  --- are configured in plugins/lsp/lspconfig.lua and conform.nvim
  --- @see https://github.com/olexsmir/gopher.nvim
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}

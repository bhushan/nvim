-- Treesitter configuration (Neovim 0.11+)

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    -- Enable highlighting, indentation, and folding per filetype
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldenable = false
        end
      end,
    })
  end,
}

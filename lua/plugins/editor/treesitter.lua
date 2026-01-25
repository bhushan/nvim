-- [[ Configure Treesitter ]]
-- New nvim-treesitter API (requires Neovim 0.11+)
-- See: https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false, -- treesitter does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    -- List of parsers to install
    local parsers = {
      'bash',
      'c',
      'css',
      'diff',
      'dockerfile',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'git_rebase',
      'graphql',
      'html',
      'java',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'php',
      'phpdoc',
      'python',
      'query',
      'regex',
      'scss',
      'sql',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'vue',
      'xml',
      'yaml',
    }

    -- Install parsers asynchronously
    require('nvim-treesitter').install(parsers)

    -- Enable treesitter highlighting for all supported filetypes
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        -- Check if parser exists for this filetype
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          -- Enable treesitter-based indentation
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Enable treesitter-based folding
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ok = pcall(vim.treesitter.get_parser, args.buf)
        if ok then
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldenable = false -- Start with folds open
        end
      end,
    })
  end,
}

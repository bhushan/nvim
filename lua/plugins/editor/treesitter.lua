return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
      }

      -- Install parsers (non-blocking)
      local parsers = { 'php', 'php_only', 'javascript', 'markdown', 'markdown_inline', 'json', 'css', 'lua', 'html' }
      require('nvim-treesitter').install(parsers)

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
  },

  -- Sticky context: pin function/class header at top when scrolling
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 20,
      multiline_threshold = 1,
      trim_scope = 'outer',
      mode = 'cursor',
    },
  },
}

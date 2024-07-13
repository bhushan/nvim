-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

-- Prefer git instead of curl in order to improve connectivity in some environments
require('nvim-treesitter.install').prefer_git = true

require('nvim-treesitter.configs').setup {
  modules = {},
  sync_install = false,
  ignore_install = {},
  ensure_installed = {
    'bash',
    'c',
    'diff',
    'lua',
    'luadoc',
    'markdown',
    'vim',
    'vimdoc',
    'html',
    'css',
    'scss',
    'javascript',
    'jsdoc',
    'typescript',
    'json',
    'dockerfile',
    'java',
    'php',
    -- "help",
    'git_rebase',
    'gitcommit',
    'gitignore',
    'gitattributes',
    'python',
  },
  -- Autoinstall languages that are not installed
  auto_install = true,
  highlight = {
    enable = true,
    disable = { 'neo-tree' },
    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
}

-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

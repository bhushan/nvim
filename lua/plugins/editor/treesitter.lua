-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

-- Prefer git instead of curl in order to improve connectivity in some environments
require('nvim-treesitter.install').prefer_git = true

-- Set up blade filetype detection for Laravel templates
vim.filetype.add {
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
}

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
    'blade', -- Laravel Blade templates
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

-- Configure Blade parser for Laravel templates
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config.blade = {
  install_info = {
    url = 'https://github.com/EmranMR/tree-sitter-blade',
    files = { 'src/parser.c' },
    branch = 'main',
  },
  filetype = 'blade',
}

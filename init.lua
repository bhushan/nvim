-- plugins
require('plugins')

-- settings/options and keybindings
require('options')
require('keybindings')

-- configurations
require('treesitter-config')
require('lualine-config')
require('nvim-tree-config')
require('neoformat-config')
require('telescope-config')

vim.cmd('colorscheme carbon')

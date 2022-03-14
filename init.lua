-- plugins
require("plugins")

-- settings/options and keybindings
require("options")
require("keybindings")

-- configurations
require("treesitter-config")
require("nvim-tree-config")
require("neoformat-config")
require("telescope-config")
require("lsp-config")

-- theme
require("lualine-config")
-- require("inspired-github-config")
vim.cmd [[ colorscheme github_light ]]

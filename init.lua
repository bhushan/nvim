-- plugins
require("plugins")

-- settings/options and keybindings
require("options")
require("keybindings")

-- configurations
require("treesitter-config")
-- require("nvim-tree-config")
require("neoformat-config")
require("telescope-config")
require("lsp-config")

-- dynamically set theme based on zshell env variable
if os.getenv("LIGHT_MODE") then
    vim.cmd([[ colorscheme github_light ]])
else
    vim.cmd([[ colorscheme github_dark ]])
end

-- should be after setting theme
require("lualine-config")

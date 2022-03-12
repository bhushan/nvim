require("nvim-tree").setup({
    view = {
        width = 70,
        height = 70,
        hide_root_folder = true,
        side = "right",
    },
})

-- keymaps
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>1", ":NvimTreeToggle<cr>", opts)

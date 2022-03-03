vim.g.mapleader = ","

local map = vim.api.nvim_set_keymap

map("i", "jj", "<ESC>", {
	noremap = true,
	silent = true,
})

-- remove highlighted search
map("n", "<leader><space>", ":nohlsearch<cr>", {
	noremap = true,
	silent = false,
})

-- save
map("n", "<leader>w", ":w<cr>", {
	noremap = true,
	silent = true,
})

-- quit
map("n", "<leader>q", ":q<cr>", {
	noremap = true,
	silent = true,
})

-- force quit
map("n", "<leader>fq", ":q!<cr>", {
	noremap = true,
	silent = true,
})

-- easy movement between panes
map("n", "<c-h>", "<c-w>h", {
	noremap = true,
	silent = false,
})
map("n", "<c-l>", "<c-w>l", {
	noremap = true,
	silent = false,
})
map("n", "<c-j>", "<c-w>j", {
	noremap = true,
	silent = false,
})
map("n", "<c-k>", "<c-w>k", {
	noremap = true,
	silent = false,
})

-- easy indenting code
map("v", "<", "<gv", {
	noremap = true,
	silent = false,
})
map("v", ">", ">gv", {
	noremap = true,
	silent = false,
})

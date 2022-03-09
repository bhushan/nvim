vim.g.mapleader = ","

local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

map("i", "jj", "<ESC>", opts)

-- remove highlighted search
map("n", "<leader><space>", ":nohlsearch<cr>", opts)

-- save
map("n", "<leader>w", ":w<cr>", opts)

-- quit
map("n", "<leader>q", ":q<cr>", opts)

-- force quit
map("n", "<leader>fq", ":q!<cr>", opts)

-- easy movement between panes
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-l>", "<c-w>l", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)

-- easy indenting code
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
